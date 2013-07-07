// http://mecab.googlecode.com/svn/trunk/mecab/doc/bindings.html
%module MeCab

namespace MeCab {

  class Tagger {

     // str を解析して文字列として結果を得ます. len は str の長さ(省略可能)
     string parse(string str, int len);
  
     // parse と同じ
     string parseToString(string str, int len);
  
     // str を解析して MeCab::Node 型の形態素を返します. 
     // この形態素は文頭を示すもので, next を順に辿ることで全形態素にアクセスできます
     Node parseToNode(string str, int len);
  
     // parse の Nbest 版です. N に nbest の個数を指定します.
     // この機能を使う場合は, 起動時オプションとして -l 1 を指定する必要があります
     string parseNBest(int N, string str, int len);
  
     // 解析結果を, 確からしいものから順番に取得する場合にこの関数で初期化を行います.
     bool  parseNBestInit(string str, int len);
  
     // parseNbestInit() の後, この関数を順次呼ぶことで, 確からしい解析結果を, 順番に取得できます.
     string next();
  
     // next() と同じですが, MeCab::Node を返します.
     Node  nextNode();
  };
  
  #define MECAB_NOR_NODE  0
  #define MECAB_UNK_NODE  1
  #define MECAB_BOS_NODE  2
  #define MECAB_EOS_NODE  3
  
  struct Node {

    struct Node  prev;  // 一つ前の形態素へのポインタ
    struct Node  next;  // 一つ先の形態素へのポインタ
    
    struct Node  enext; // 同じ位置で終わる形態素へのポインタ
    struct Node  bnext; // 同じ開始位置で始まる形態素へのポインタ
  
    string surface;             // 形態素の文字列情報 
  			      
    string feature;             // CSV で表記された素性情報
    unsigned int   length;      // 形態素の長さ
    unsigned int   rlength;     // 形態素の長さ(先頭のスペースを含む)
    unsigned int   id;          // 形態素に付与される ユニークID
    unsigned short rcAttr;      // 右文脈 id 
    unsigned short lcAttr;      // 左文脈 id
    unsigned short posid;       // 形態素 ID (未使用)
    unsigned char  char_type;   // 文字種情報
    unsigned char  stat;        // 形態素の種類: 以下のマクロの値
                                // #define MECAB_NOR_NODE  0
                                // #define MECAB_UNK_NODE  1
                                // #define MECAB_BOS_NODE  2
                                // #define MECAB_EOS_NODE  3
    unsigned char  isbest;      // ベスト解の場合 1, それ以外 0
  
    float          alpha;       // forward backward の foward log 確率
    float          beta;        // forward backward の backward log 確率 
    float          prob;        // 周辺確率
                                // alpha, beta, prob は -l 2 オプションを指定した時に定義されます
  
    short          wcost;       // 単語生起コスト
    long           cost;        // 累積コスト
  };
}

