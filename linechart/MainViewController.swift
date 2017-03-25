
import UIKit
import QuartzCore

class MainViewController: UIViewController, LineChartDelegate {

    
    
    var label = UILabel()
    var lineChart: LineChart!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var views: [String: AnyObject] = [:]
        
        label.text = "..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        views["label"] = label
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[label]", options: [], metrics: nil, views: views))
        
        // simple arrays
        let data: [CGFloat] = [0, 4, 2, 11, 13, 15]
        let data2: [CGFloat] = [1, 3, 5, 13, 17, 20]
        
        // simple line with custom x axis labels
        let xLabels: [String] = ["25", "26", "27", "28", "29", "30"]
        
        lineChart = LineChart()
        lineChart.animation.enabled = false
        lineChart.area = false
        lineChart.x.labels.visible = true
        lineChart.x.labels.SIIMode = true
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 5
        lineChart.x.labels.values = xLabels
        lineChart.y.labels.visible = false
        //lineChart.addLine(data2)
        lineChart.x.grid.visible = false
        lineChart.y.grid.visible = false
        lineChart.x.axis.visible = false
        lineChart.y.axis.visible = false
        
        lineChart.x.axis.inset = 15
        lineChart.x.labels.marginTop = 30
        lineChart.x.labels.paddingTopBottom = 5
        lineChart.x.labels.backgroundColor = UIColor.lightGray
        
        lineChart.dots.color = #colorLiteral(red: 0.003921568627, green: 0.5921568627, blue: 0.6196078431, alpha: 1)
        lineChart.dots.innerRadius = 8
        lineChart.dots.outerRadius = 12
        lineChart.dots.innerColor = UIColor.white
        lineChart.colors = [#colorLiteral(red: 0.003921568627, green: 0.5921568627, blue: 0.6196078431, alpha: 1)]
        
        lineChart.addLine(data)
        
        
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.delegate = self
        self.view.addSubview(lineChart)
        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label]-[chart(==200)]", options: [], metrics: nil, views: views))

        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//            self.lineChart.clear()
//            self.lineChart.addLine(data2)
//        })
    
        let scale = LinearScale(domain: [0, 100], range: [0.0, 100.0])
        let linear = scale.scale()
        let invert = scale.invert()
        print(linear(2.5)) // 50
        print(invert(50)) // 2.5
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    /**
     * Line chart delegate method.
     */
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>) {
        label.text = "x: \(x)     y: \(yValues)"
    }
    
    
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }

}
