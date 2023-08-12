1.0.34 introduces several Windows version dependent methods.
GetExtendedAttributes and InitializeReportForID work from Win 2000 on
whereas GetInputReport and SetOutputReport work from Wiin XP on.
The component still works in Win 9x, but the new methods simply fail.
To make that possible HID.pas now requires {$DEFINE HID_LINKONREQUEST}.
SimpleHIDWrite has been modernized. It is now a full HID test tool.
The BCB files have been removed. The component still supports BCB, but
the files were outdated and i cannot support them for lack of BCB.
-----------------------------------------------------------------------------
1.0.33 (only in JVCL) fixes DLL problem. If a TJvHidDeviceController is
ionstanciated in a DLL the reader thread does not try to Synchronize its
events anymore. Before that the thread got stuck in the Synchronize. 
-----------------------------------------------------------------------------
1.0.32 (only in JVCL) fixes shutdown problem by calling DefWindowProc for the
messages received in the WndProc of AllocateHWnd.
-----------------------------------------------------------------------------
1.0.31 New method CheckOut added added to TJvHidDevice to allow a device
to check out itself in OnArrival event. CheckOutByIndex retained only
for compatibility.
-----------------------------------------------------------------------------
1.0.30 Now uses AllocateHWnd and DeallocateHWnd to catch WM_DEVICECHANGE
through its own hidden window. Now the component works if used in a DLL.
-----------------------------------------------------------------------------
1.0.29 version number has only be given to a JVCL version of the file.
-----------------------------------------------------------------------------
1.0.28 has been updated to newest JVCL standard. It also fixes
a problem with dynamically created TJvHidDeviceController components.
-----------------------------------------------------------------------------
1.0.27 version number has only be given to a JVCL version of the file.
-----------------------------------------------------------------------------
1.0.26 Only the Delphi demo HIDinDLLDemo has been added.
It solves the problem that no WM_DEVICECHANGE messages are received
if a TJvHidDeviceController is instanciated in a DLL.
The IFDEF UNITVERSIONING at the end of the file JvHidControllerClass.pas
is for the JediVCL only and should never be activated for
the standalone component.
-----------------------------------------------------------------------------
1.0.25 The component now uses a PostMessage to trigger DeviceChange
after the constructor has finished. This ensures that all global
Delphi variables (namely Application.MainForm) are initialized.
-----------------------------------------------------------------------------
1.0.24 The component now initializes in the Loaded method like
any other wellbehaved component. The string constants
cHidKeyboardClass and cHidMouseClass have been deleted.
These class descriptions are not used anymore by Windows 2000/XP.
The source style is now Jedi standard.
Only the Delphi demos have been updated. BCB waiting for a helping hand.
-----------------------------------------------------------------------------
1.0.23 All TStringLists in the API have been replaced by TStrings
for improved flexibility. The exception for a second TJvHidDeviceController
instance does not crash the IDE anymore.
-----------------------------------------------------------------------------
1.0.22 Two new events have been implemented in TJvHidDeviceController.
OnArrival and OnRemoval. They fire for individual devices being
plugged or unplugged. OnRemoval is equivalent to OnUnplug, but
happens in the TJvHidDeviceController instead of the TJvHidDevice.
OnDeviceChange fires after all OnArrival or OnRemoval events.
The ReadWriteDemo has been updated to show arrivals and removals.
Fixed some values read with GetRegistryProperty* functions.
Property Security has been renamed SecuritySDS.
-----------------------------------------------------------------------------
1.0.21 mainly improves the integration in the JediVCL.
IFDEF USEJVCL is used instead of STANDALONE.
resourcestrings have been implemented to ease localization.
FreeAndNil removed to allow Delphi 4 compatibility.
-----------------------------------------------------------------------------
1.0.19 fixes a copy & paste bug in SetNumOverlappedBuffers.
A new sample has been added for the infrared receiver
of the new IO-Warrior 24.
Some small fixes to the demos.
-----------------------------------------------------------------------------
1.0.18 has a Borland C++ Builder 6 project for the component
and C++ versions of the demos. The demos are straight
conversions from the Delphi versions which means they are
sometimes a bit clumsy.
The Demo directory has been reorganized into a BCB
branch and a Delphi branch. All projects have relative
search pathes set in their options.
All demos have been reworked to use CheckOutByCallback and
OnData event if needed. Several bugs have been fixed.
The batch file CompileExamplesDelphi.bat compiles all
Delphi demos.
The only issue left is that you have to copy all generated
.hpp files from the base directory to the BCB directory
if you install the BCB version.
-----------------------------------------------------------------------------
1.0.17 adds another check out method. CheckOutByCallback allows
customized check outs. This simplifies the task to find one
of the members of a composite device for example.
A CountByCallback method accompanies the check out method as usual.
The OnData event now starts its thread only if the device is
readable.
-----------------------------------------------------------------------------
1.0.16 adds an OnDataError and an OnDeviceDataError event.
The thread implementing the OnData event now does not terminate
anymore when encountering a read error. It throws an OnDataError
instead. OnDeviceDataError assigns the error event to all
devices in the usual way.
ReadWriteDemo has been updated to use the new feature.
-----------------------------------------------------------------------------
1.0.15 adds a standard Tag property to TJvHidDevice.
-----------------------------------------------------------------------------
1.0.14 adds an OnData event to TJvHidDevice. It is modelled
after the ReadWriteDemo by starting a read thread on the device.
Consequently the ReadWriteDemo has been simplified to use the
new OnData event.
TJvHidDeviceController.OnDeviceData,
TJvHidDeviceController.DevThreadSleepTime and
TJvHidDevice.ThreadSleepTime accompany the new event.
Destroying a checked out and plugged in TJvHidDevice now
results in a complete clone object created. The older
version would lose event assignment.
The IO-WarriorLCDDemo has been added. It can access
IO-Warrior Kits with optional LCD. The IO-WarriorLCDDemo and
the IO-WarriorDemo can be run in parallel on the same device.
-----------------------------------------------------------------------------
1.0.13 more and updated demos. The new C++ ExternalDemo is the first
3rd party demo.
WARNING! The index of LinkCollectionNodes property is now
0-based instead of 1-based!
CollectionDemo has been fixed.
-----------------------------------------------------------------------------
1.0.12 has the completed UsagePages in HidUsage.pas.
CollectionDemo and UsagesDemo show them.
-----------------------------------------------------------------------------
1.0.11 has improved and cleaned up examples.
HidUsage.pas has been extended to include new usage pages
and usages. The new UsageDemo explores this.
More usage pages and usages coming soon.
The new IO-WarriorDemo is intended for the IO-Warrior Kit
available from Code Mercenaries http://www.codemercs.com
The output directory and the Unit output directories have
been set in the project options. Do not forget to include
the Unit output directory into the Delphi unit search path.
-----------------------------------------------------------------------------
1.0.10 SetupApi.pas has been improved to allow smooth usage in the
Jedi-VCL. Also some problems with C++ Builder fixed.
-----------------------------------------------------------------------------
1.0.9 introduces HidOverlappedReadResult and HidOverlappedWriteResult
mainly to allow reading of different sized reports. The ReadWriteDemo
and the help have been updated accordingly.
-----------------------------------------------------------------------------
1.0.8 fixes a copy-and-paste bug in GetProductName.
-----------------------------------------------------------------------------
1.0.7 only has a fixed ReadWriteDemo and an improvement
in SetupApi.pas.
-----------------------------------------------------------------------------
1.0.6 has the new helper function HidErrorString.
-----------------------------------------------------------------------------
1.0.5 only has internal changes.
The local GetRegistryProperty functions have been made
private methods of TJvHidPnPInfo because they belong there.
-----------------------------------------------------------------------------
1.0.4 introduces some changes to have the HID component
coexist smoothly with the new USB component.
TJvHidPnPInfo and TJvHidOpenExMode = (omhRead, omhWrite)
have been renamed to allows that. TJvHidPnPInfo has been
changed to a class to allow easier internal handling.
Some elements have been changed to TStringList.
SerialNumber has the fix again which was dropped in the
last version.
HasReadWriteAccess has been introduced. It allows to
check if the device is readable or not. Devices like
keyboards and mice are already opened exclusively by Windows.
published has been removed from TJvHidDevice because
such an object can not be shown in the IDE or streamed
to a file.
The component and all examples have been changed to Delphi 6.
They still work with Delphi 5 and presumably with Delphi 4.
The CollectionDemo has been fixed and improved.
The GreyMouser demo has been integrated into the ReadWriteDemo.
-----------------------------------------------------------------------------
1.0.3 is a bugfix version.
The file name of HidControllerClass.pas has been changed to
JvHidControllerClass.pas to be compatible with the Jedi VCL.
STANDALONE has been defined to allow integration in the JVCL.
CancelIO is now loaded dynamically because it is missing
from Windows 95.
The LanguageStrings always contained the local language
because of a bug in interpreting the language IDs. Fixed.
The C++ Builder package project has been removed. Create it
yourself by simply adding JvHidControllerClass.pas to a new
package project. The BCB 6 Trial version did not work with
some BCB versions.
The reading of the device properties in CtlCreate has been
removed almost entirely. The properties are now only read
when accessed. This solves problems with bad drivers for
some devices. Reading the device could crash the computer.
Now it only crashes when the device is accessed. Previously
it would crash if the device was plugged even if your
program was not interested in the device at all.
-----------------------------------------------------------------------------
1.0.2 is a bugfix version.
Dropping a second TJvHidDeviceController on a form did not
give the proper exception because of a bug the destructor.
CtlCreate raised a range check error because the buffer fix
below was incomplete.
Changed the demos to be Delphi 5 projects. Added "..\.."
to their search pathes. That should make them link without
problems.
-----------------------------------------------------------------------------
Added the new functions (Win XP only) HidD_GetInputReport and
HidD_SetOutputReport to HID.pas. Fixed a bug where the buffer
for HidD_GetManufacturerString was too long for XP!
Changed the .dpk back to Delphi 5 version. Delphi 6 can use it.
Added "cHidControllerClassVersion = '1.0.1';" for this version.
-----------------------------------------------------------------------------
Improved Windows 2000 and XP compatibility.
PhysicalDecriptor is now of correct type.
LinkCollectionNodes access changed to be 0 based.
The C++ Builder package is for BCB 6. For earlier BCB versions
best recreate it by adding HidControllerClass.pas to a new package.
-----------------------------------------------------------------------------
PnPInfo extended to carry ALL possible registry entries.
-----------------------------------------------------------------------------
Introduced property PnPInfo: TJvPnPInfo. The properties RegDescr
(as DeviceDescr), RegClass (as ClassDescr), DeviceID and DevicePath have
been moved to this record. All relevant registry entries for HID devices
have been added.
-----------------------------------------------------------------------------
All strings from the device and parameters to be matched
with such strings have been changed to WideString.

Added some methods to TJvHidDeviceController.
CountByClass, CountByID, CountByProductName, CountByVendorName
count the currently plugged devices. The match criteria are the
same as with the CheckOut methods.
Added some "const" to parameters.
-----------------------------------------------------------------------------
The component is now C++ Builder compatible.

PreparsedData is now a public property of the correct Pointer type.
This was the last BCB incompatibility remaining.

HidOverlappedHandle has been separated into HidOverlappedRead
and HidOverlappedWrite handles to allow reading and writing in
separate threads. OpenFileEx and CloseFileEx now have a mode
parameter to address one of the file handles.
Added on request of a modem programmer.

The new property DeviceStringsUnicode works just like DeviceStrings
but does not convert the Unicode strings to Ansi strings.
Added on request of a russian programmer.

"packed" has been removed from all records of HID.pas. It was wrong.
-----------------------------------------------------------------------------
The component now works at design time. DoDeviceChange has been
changed to the published method DeviceChange to allow calling it at
design time. Its implementation has been optimized.
HID.pas and SetupApi.pas now default to load their DLL dynamically.
This is allows programs using USB or non-USB versions of a device
to run on Win95 where there is no USB. The component simply finds
no USB devices and the program can search for non-USB devices.
Added class method HidVersion which reads the version information from
HID.DLL.
-----------------------------------------------------------------------------
Method GetPhysicalDescriptor has been replaced by string property
PhysicalDescriptor.
ReadFileEx and WriteFileEx implemented. HidOverlappedHandle,
NumOverlappedBuffers, OpenFileEx and CloseFileEx accompany
these new methods.
The internal access to the device registry entries
is now made with SetupDiGetDeviceRegistryProperty and
is therefore Win2K safe.
The property HardWareKey has been deleted because it is not
needed anymore.
DeviceStrings and LinkCollectionNodes have been changed
to indexed properties. Their base index now starts correctly with 1.
Two utility functions HidCheck and HidError have been added and
documented in the help.
Added NumCheckedInDevices, NumCheckedOutDevices and NumUnpluggedDevices.
Various small improvements and bugfixes.
-----------------------------------------------------------------------------
Bugfixes since last version:
The events are set to nil in the destructor. This prevents
strange problems with debugging.
The index of the DeviceStrings now corresponds with their index
when read in from the device. This now correctly represents
device strings with nonconsecutive indices.
DeviceIoControl has been added as a method.

A new sample ReadWriteDemo has been added.
> This sample and its data is rigged to the www.lvr.com
> hid sample for the cypress evaluation board.
Bugfixes since last version:
PAS\HID.PAS:
All params like "Report: PChar" changed to "var Report"
This allows the use of buffers or records for the reports
without any compiler warnings.
DEMOS\HIDCLASS\HidControllerClass.pas:
Propagated the untyped Report params up to the methods.
Added ReadFile and WriteFile methods.
The list of the language names (LanguageStrings) has
been introduced.
Fixed the central function FillInList to correctly use
the SetupDi* functions.
Added an exception to TJvHidDeviceController to prevent
instanciating a second one.
Various minor fixes. Help file completed.
-----------------------------------------------------------------------------
Hid.pas is a conversion of HIDPI.H and HIDSDI.H since both function groups
reside in HID.DLL and HIDSDI.H includes HIDPI.H anyway.
I added HidD_Hello() to the conversion.
This is the undocumented easter egg function of HID.DLL.
See Hid.pas for details.

HidToken.pas is a simple conversion of hidtoken.h.
It contains only consts and some converted checking macros.

HidUsage.pas is a more than complete conversion from hidusage.h
The TUsage and PUsage types have been moved to Hid.pas.
This eliminates the need to include HidUsage.pas in all HID projects.
So HidToken.pas and HidUsage.pas are only needed in projects where
the named constants are needed.

Some sets of constants have been completed (mainly keys).
The constants are for Usage, UsagePage and Usage values.
That is they describe the real data you will get from USB devices.

For real information read "USB HID Usage Tables 1.1rc3.pdf"
or newer versions thereof from www.usb.org.

I added some comments marked (rom) to clarify some things.
Changes from Windows 98 DDK to Windows 2000 DDK i marked (Win2000).
The new functions documented in the Windows 2000 DDK have been implemented
already in the HID.DLL of Windows 98 SE.
The function declarations are inside a {$IFDEF WIN2000}.

You will need SetupApi.pas from the SetupApi conversion and DBT.pas from the DBT conversion.

The component in Demos\HidClass gives you access to the complete HID API.
There is no need to use the functions directly.

known issues:
some of the new constants in HidUsage.pas may be named incorrectly
as a german i do not know all the real english key names
