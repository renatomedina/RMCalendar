
import JTAppleCalendar

private let preDateSelectable = false
private let todayColor = UIColor.lightGray
private let selectableDateColor = UIColor.black
private let selectedRoundColor = UIColor.blue

class CellView: JTAppleDayCellView {
    
    @IBOutlet weak var stableBackView: AnimationView!
    @IBOutlet var selectedView: AnimationView!
    @IBOutlet var dayLabel: UILabel!
    
    var startDate: Date = Date()
    var endDate: Date = Date()
    
    func handleCellSelection(cellState: CellState, date: Date, selectedDate: Date) {
        
        //InDate, OutDate
        if cellState.dateBelongsTo != .thisMonth {
            self.dayLabel.text = ""
            self.isUserInteractionEnabled = false
            self.stableBackView.isHidden = true
        } else if !(startDate.isSmaller(to: date) && endDate.isBigger(to: date)) && !preDateSelectable {
            self.dayLabel.text = cellState.text
            self.dayLabel.textColor = UIColor.lightGray
            self.isUserInteractionEnabled = false
            self.stableBackView.isHidden = true
        }else{
            self.stableBackView.isHidden = false
            self.isUserInteractionEnabled = true
            dayLabel.text = cellState.text
            dayLabel.textColor = selectableDateColor
        }
        
        configueViewIntoBubbleView(cellState, date: date)
        
    }
    
    func cellSelectionChanged(_ cellState: CellState, date: Date) {
        if cellState.isSelected == true {
            if self.selectedView.isHidden == true {
                configueViewIntoBubbleView(cellState, date: date)
                self.selectedView.animateWithBounceEffect(withCompletionHandler: {
                })
            }
        } else {
            configueViewIntoBubbleView(cellState, date: date, animateDeselection: true)
        }
    }
    
    fileprivate func configueViewIntoBubbleView(_ cellState: CellState, date: Date, animateDeselection: Bool = false) {
        if cellState.isSelected && self.isUserInteractionEnabled {
            self.selectedView.isHidden = false
            self.selectedView.layer.cornerRadius = self.frame.height * 0.37
            self.selectedView.layer.backgroundColor = selectedRoundColor.cgColor
            self.dayLabel.textColor = .white
        } else {
            if animateDeselection {
                if date.isEqual(to: Date())
                {
                    self.dayLabel.textColor = todayColor
                }else{
                    self.dayLabel.textColor = selectableDateColor
                }
                if self.selectedView.isHidden == false {
                    self.selectedView.animateWithFadeEffect(withCompletionHandler: { () -> Void in
                        self.selectedView.isHidden = true
                        self.selectedView.alpha = 1
                    })
                }
            } else {
                self.selectedView.isHidden = true
            }
        }
    }
}
