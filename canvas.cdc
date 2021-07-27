
pub struct Canvas{
    pub let width: UInt8
    pub let height: UInt8
    pub let pixels: String
    
    init (width: UInt8, height: UInt8, pixels: String){
        self.width = width
        self.height = height
        self.pixels = pixels
    }
}

pub resource Picture {
    pub let canvas: Canvas

    init(canvas: Canvas){
        self.canvas = canvas
    }
}

//"_"Means to skip the label
//Return value is string (Comes after the ":" at the end of the function header)
pub fun serializeStringArray(_ lines: [String]): String{
    var buffer = ""
    for line in lines{
        buffer = buffer.concat(line)
    }

    return buffer
}


//W1Q1
pub fun display(canvas: Canvas){
    log("@=====@")
    var index: UInt8 = 0
    let border = "|"
    while index < (canvas.width * canvas.height)
        {
            var line = canvas.pixels.slice(from: Int(index), upTo: Int(index + canvas.width))
            log(border.concat(line).concat(border))
            index = index + canvas.width
        }
    log("@=====@")
}


//W1Q2
pub resource printer{
    pub var canvasDictionary: {String:Int}

    pub fun print(canvas: Canvas): @Picture?
    {
        if(self.canvasDictionary.containsKey(canvas.pixels)){
            return nil
        }
        else{
            self.canvasDictionary[canvas.pixels] = 1
            let picture <- create Picture(canvas: canvas)
            display(canvas: picture.canvas)
            return <- picture
        }
        
    }

    init(){
        self.canvasDictionary = {}
    }
}




pub fun main(){

    

    let pixelsX = [
        "*   *",
        " * * ",
        "  *  ",
        " * * ",
        "*   *"
        
    ]

    

    let pixelsF = [
        "*****",
        "*    ",
        "*****",
        "*    ",
        "*    "
        
    ]

    let pixelsL = [
        "*    ",
        "*    ",
        "*    ",
        "*    ",
        "*****"
        
    ]

    let pixelsO = [
        "*****",
        "*   *",
        "*   *",
        "*   *",
        "*****"
        
    ]

    let pixelsW = [
        "*   *",
        "*   *",
        "* * *",
        " * * ",
        " * * "
        
    ]

    let canvasX = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsX)
    )

    let canvasX2 = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsX)
    )

    let canvasF = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsF)
    )

    let canvasL = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsL)
    )

    let canvasO = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsO)
    )

    let canvasW = Canvas(
        width: 5,
        height: 5,
        pixels: serializeStringArray(pixelsW)
    )

    let canvasArray = [canvasX, canvasX2, canvasF, canvasL, canvasO, canvasW]


    

    let letterX <- create Picture(canvas: canvasX)
    log(letterX.canvas)
    destroy letterX

    //W1Q1
    display(canvas: canvasX)

    //W2Q2 - Kind of confusing....
    let printer <- create printer()
    for item in canvasArray
    {
        let picture <- printer.print(canvas: item)
        destroy picture
    }
      destroy printer
}