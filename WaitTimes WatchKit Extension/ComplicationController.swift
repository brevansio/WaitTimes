//
//  ComplicationController.swift
//  WaitTimes WatchKit Extension
//
//  Created by Bruce Evans on 2021/02/20.
//

import ClockKit
import SwiftUI

extension UIColor {
    static let tdlTheme = UIColor(displayP3Red: 197 / 255, green: 135 / 255, blue: 164 / 255, alpha: 1)
}

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication",
                                      displayName: "Clockwise 待ち時間",
                                      supportedFamilies: [.circularSmall, .graphicCircular, .graphicCorner,
                                                          .modularSmall, .utilitarianSmall, .utilitarianSmallFlat])
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry

        let template: CLKComplicationTemplate

        switch complication.family {
        case .circularSmall:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
            template = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: imageProvider)
        case .graphicCircular:
            template = CLKComplicationTemplateGraphicCircularView(Image("Complication/Circular"))
        case .graphicCorner:
            let imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!)
            template = CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: imageProvider)
        case .modularSmall:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
            let textProvider = CLKTextProvider(format: "待ち時間")
            template = CLKComplicationTemplateModularSmallStackImage(line1ImageProvider: imageProvider,
                                                                     line2TextProvider: textProvider)
        case .utilitarianSmall:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            template = CLKComplicationTemplateUtilitarianSmallSquare(imageProvider: imageProvider)
        case .utilitarianSmallFlat:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            let textProvider = CLKTextProvider(format: "待ち時間")
            template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: textProvider,
                                                                   imageProvider: imageProvider)
        case .graphicRectangular, .modularLarge, .utilitarianLarge, .extraLarge, .graphicExtraLarge, .graphicBezel:
            handler(nil)
            return
        @unknown default:
            handler(nil)
            return
        }

        template.tintColor = .tdlTheme

        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template: CLKComplicationTemplate

        switch complication.family {
        case .circularSmall:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
            template = CLKComplicationTemplateCircularSmallSimpleImage(imageProvider: imageProvider)
        case .graphicCircular:
            template = CLKComplicationTemplateGraphicCircularView(Image("Complication/Graphic Circular"))
        case .graphicCorner:
            let imageProvider = CLKFullColorImageProvider(fullColorImage: UIImage(named: "Complication/Graphic Corner")!)
            template = CLKComplicationTemplateGraphicCornerCircularImage(imageProvider: imageProvider)
        case .modularSmall:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
            let textProvider = CLKTextProvider(format: "待ち時間")
            template = CLKComplicationTemplateModularSmallStackImage(line1ImageProvider: imageProvider,
                                                                     line2TextProvider: textProvider)
        case .utilitarianSmall:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            template = CLKComplicationTemplateUtilitarianSmallSquare(imageProvider: imageProvider)
        case .utilitarianSmallFlat:
            let imageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
            let textProvider = CLKTextProvider(format: "待ち時間")
            template = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: textProvider,
                                                                   imageProvider: imageProvider)
        case .graphicRectangular, .modularLarge, .utilitarianLarge, .extraLarge, .graphicExtraLarge, .graphicBezel:
            handler(nil)
            return
        @unknown default:
            handler(nil)
            return
        }

        template.tintColor = .tdlTheme

        handler(template)
    }
}
