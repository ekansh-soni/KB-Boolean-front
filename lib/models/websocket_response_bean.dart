
class WebSocketResponseBean {
  List<LiveData>? liveData;
  List<Rates>? rates;

  WebSocketResponseBean({this.liveData, this.rates});

  WebSocketResponseBean.fromJson(Map<String, dynamic> json) {
    liveData = json["live_data"] == null ? null : (json["live_data"] as List).map((e) => LiveData.fromJson(e)).toList();
    rates = json["rates"] == null ? null : (json["rates"] as List).map((e) => Rates.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(liveData != null) {
      _data["live_data"] = liveData?.map((e) => e.toJson()).toList();
    }
    if(rates != null) {
      _data["rates"] = rates?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Rates {
  String? symbolId;
  String? symbol;
  String? bid;
  String? ask;
  String? high;
  String? low;
  String? source;
  String? stock;
  String? client;
  String? instrumentIdentifier;
  String? time;
  String? isDisplay;
  String? isDisplayTrading;
  String? isDisplayTerminal;
  String? grams;
  String? cityId;
  String? mcxBid;
  String? mcxAsk;
  String? premium;
  String? purity;
  String? isDisplayWidget;
  String? diff;
  String? description;
  String? displayRateType;
  String? symbolType;
  String? premiumBuy;

  Rates({this.symbolId, this.symbol, this.bid, this.ask, this.high, this.low, this.source, this.stock, this.client, this.instrumentIdentifier, this.time, this.isDisplay, this.isDisplayTrading, this.isDisplayTerminal, this.grams, this.cityId, this.mcxBid, this.mcxAsk, this.premium, this.purity, this.isDisplayWidget, this.diff, this.description, this.displayRateType, this.symbolType, this.premiumBuy});

  Rates.fromJson(Map<String, dynamic> json) {
    symbolId = json["SymbolId"];
    symbol = json["Symbol"];
    bid = json["Bid"];
    ask = json["Ask"];
    high = json["High"];
    low = json["Low"];
    source = json["Source"];
    stock = json["Stock"];
    client = json["Client"];
    instrumentIdentifier = json["InstrumentIdentifier"];
    time = json["Time"];
    isDisplay = json["IsDisplay"];
    isDisplayTrading = json["IsDisplayTrading"];
    isDisplayTerminal = json["IsDisplayTerminal"];
    grams = json["Grams"];
    cityId = json["cityId"];
    mcxBid = json["McxBid"];
    mcxAsk = json["McxAsk"];
    premium = json["Premium"];
    purity = json["Purity"];
    isDisplayWidget = json["IsDisplayWidget"];
    diff = json["Diff"];
    description = json["Description"];
    displayRateType = json["DisplayRateType"];
    symbolType = json["SymbolType"];
    premiumBuy = json["PremiumBuy"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["SymbolId"] = symbolId;
    _data["Symbol"] = symbol;
    _data["Bid"] = bid;
    _data["Ask"] = ask;
    _data["High"] = high;
    _data["Low"] = low;
    _data["Source"] = source;
    _data["Stock"] = stock;
    _data["Client"] = client;
    _data["InstrumentIdentifier"] = instrumentIdentifier;
    _data["Time"] = time;
    _data["IsDisplay"] = isDisplay;
    _data["IsDisplayTrading"] = isDisplayTrading;
    _data["IsDisplayTerminal"] = isDisplayTerminal;
    _data["Grams"] = grams;
    _data["cityId"] = cityId;
    _data["McxBid"] = mcxBid;
    _data["McxAsk"] = mcxAsk;
    _data["Premium"] = premium;
    _data["Purity"] = purity;
    _data["IsDisplayWidget"] = isDisplayWidget;
    _data["Diff"] = diff;
    _data["Description"] = description;
    _data["DisplayRateType"] = displayRateType;
    _data["SymbolType"] = symbolType;
    _data["PremiumBuy"] = premiumBuy;
    return _data;
  }
}

class LiveData {
  dynamic symbol;
  dynamic name;
  dynamic bid;
  dynamic ask;
  dynamic high;
  dynamic low;
  dynamic open;
  dynamic close;
  dynamic ltp;
  dynamic difference;
  dynamic atp;
  dynamic bq;
  dynamic tbq;
  dynamic sq;
  dynamic tsq;
  dynamic vt;
  dynamic oi;
  dynamic ltq;
  dynamic time;
  dynamic v;

  LiveData({this.symbol, this.name, this.bid, this.ask, this.high, this.low, this.open, this.close, this.ltp, this.difference, this.atp, this.bq, this.tbq, this.sq, this.tsq, this.vt, this.oi, this.ltq, this.time, this.v});

  LiveData.fromJson(Map<String, dynamic> json) {
    symbol = json["symbol"];
    name = json["Name"];
    bid = json["Bid"];
    ask = json["Ask"];
    high = json["High"];
    low = json["Low"];
    open = json["Open"];
    close = json["Close"];
    ltp = json["LTP"];
    difference = json["Difference"];
    atp = json["ATP"];
    bq = json["BQ"];
    tbq = json["TBQ"];
    sq = json["SQ"];
    tsq = json["TSQ"];
    vt = json["VT"];
    oi = json["OI"];
    ltq = json["LTQ"];
    time = json["Time"];
    v = json["V"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["symbol"] = symbol;
    _data["Name"] = name;
    _data["Bid"] = bid;
    _data["Ask"] = ask;
    _data["High"] = high;
    _data["Low"] = low;
    _data["Open"] = open;
    _data["Close"] = close;
    _data["LTP"] = ltp;
    _data["Difference"] = difference;
    _data["ATP"] = atp;
    _data["BQ"] = bq;
    _data["TBQ"] = tbq;
    _data["SQ"] = sq;
    _data["TSQ"] = tsq;
    _data["VT"] = vt;
    _data["OI"] = oi;
    _data["LTQ"] = ltq;
    _data["Time"] = time;
    _data["V"] = v;
    return _data;
  }
}
