Pod::Spec.new do |s|

  s.name         = "SegmentControl"
  s.version      = "1.0.0"
  s.summary      = ""

  s.description  = <<-DESC.strip_heredoc
                     
                   DESC

  s.license      = { type: "MIT", file: "LICENSE.md" }

  s.author             = "superkk"

  s.ios.deployment_target     = "8.0"
  s.osx.deployment_target     = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target    = "9.0"

  s.source = { git: "https://github.com/action456789/KKSegmentControl.git",
               tag: s.version }

  s.source_files          = "ReactiveObjC/*.{h,m,d}",
                            "ReactiveObjC/extobjc/*.{h,m}"

  s.private_header_files  = "**/*Private.h",
                            "**/*EXTRuntimeExtensions.h",
                            "**/RACEmpty*.h"

  s.ios.exclude_files     = "ReactiveObjC/**/*{AppKit,NSControl,NSText,NSTable}*"

  s.osx.exclude_files     = "ReactiveObjC/**/*{UIActionSheet,UIAlertView,UIBarButtonItem,"\
                            "UIButton,UICollectionReusableView,UIControl,UIDatePicker,"\
                            "UIGestureRecognizer,UIImagePicker,UIRefreshControl,"\
                            "UISegmentedControl,UISlider,UIStepper,UISwitch,UITableViewCell,"\
                            "UITableViewHeaderFooterView,UIText,MK}*"

  s.tvos.exclude_files    = "ReactiveObjC/**/*{AppKit,NSControl,NSText,NSTable,UIActionSheet,"\
                            "UIAlertView,UIDatePicker,UIImagePicker,UIRefreshControl,UISlider,"\
                            "UIStepper,UISwitch,MK}*"

  s.watchos.exclude_files = "ReactiveObjC/**/*{UIActionSheet,UIAlertView,UIBarButtonItem,"\
                            "UIButton,UICollectionReusableView,UIControl,UIDatePicker,"\
                            "UIGestureRecognizer,UIImagePicker,UIRefreshControl,"\
                            "UISegmentedControl,UISlider,UIStepper,UISwitch,UITableViewCell,"\
                            "UITableViewHeaderFooterView,UIText,MK,AppKit,NSControl,NSText,"\
                            "NSTable,NSURLConnection}*"

  s.requires_arc = true

  s.frameworks   = "Foundation"

  s.prepare_command = <<-'CMD'.strip_heredoc
                        find -E . -type f -not -name 'RAC*' -regex '.*(EXT.*|metamacros)\.[hm]$' \
                                  -execdir mv '{}' RAC'{}' \;
                        find . -regex '.*\.[hm]' \
                               -exec perl -pi \
                                          -e 's@"(?:(?!RAC)(EXT.*|metamacros))\.h"@"RAC\1.h"@' '{}' \;
                        find . -regex '.*\.[hm]' \
                               -exec perl -pi \
                                          -e 's@<ReactiveObjC/(?:(?!RAC)(EXT.*))\.h>@<ReactiveObjC/RAC\1.h>@' '{}' \;
                      CMD

end