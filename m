Subject: Re: [Openvpn-devel] Building GUI
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1079554376.69524@...41...>
In-Reply-To: <loom.20040317T113337-731@...171...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Mar 17 12:13:14 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andre Morisse <am@...188...>, openvpn-devel@lists.sourceforge.net

Andre,

Take a look at service-win32/openvpnserv.c -- this code shows how to do a
CreateProcess with redirected standard handles.

James

Andre Morisse <am@...188...> said:

> Hello together
> 
> at the moment I just trying to build up a GUI Interface for Windows to OVPN
> for easier use. The target is to build a GUI that handle a connect-up to a
> OVPN Server without showing the user all the status information and really
> confusing status outputs for "normal" user.
> Short said: Only a button connect, a field to enter a passphrase for the
> rsa key and a status indicator if connect or not.
> 
> I already programmed the GUI interface based in a system that loads the
> OVPN and starts it with the appropiate config file and redirecting the
> STDInput and STDOutput Handles to named pipes instead of a console.
> With this, the GUI ist able to read from and write to the console
> like a user, all to do is to interpret the status messages and send,
> for example, the passphrase if requested as keyboard-input.
> 
> At least, I should announce that, to get this work, I had to make minor
> changes to the io.c file and commented out the check if it is a running
> windows nt service, because redirecting the inputs&outputs is a thing
> a windows nt service would do, too. With this changes, I recompiled the
> ovpn (btw. version 1.5.0).
> 
> Now the following problem:
> When starting the rebuild version from console, everything works fine
> like it should, asking for passphrase, connecting and so on. The VPN
> connection is full usable (this was tested).
> 
> When connecting with the changed STDInput und STDOutput Params, it
> runs to, ask for the passphrase, which is send by the GUI programm and
> accepted by OVPN, runs further and loads everything like it is in console
> und stops at the message where it say "Local IP: ip:undefined" and
> "Server IP: ip:port". (This can be seen at the screenshots, too).
> 
> My question is: someone a idea why ovpn stops working when running with
> the redirected Input und Outputs (to a pipe for another programm instead
> to the pipe of the console) at the point where it should connect ?
> 
> Another idea is to start it in console, but pass the passphrase for the key
> when calling up by a command-line parameter as entered by the user in a input
> field in the gui interface and checking of a ovpn connection is established
> if there is a Task of the openvpn.exe File running in the system (really bad,
> i know - but this would work ;-)
> Anyone already done a modification for passing the passphrase by commandline
> instead of entering it at the console window and could give me some
> information about what to modify ?
> 
> At least, I have two screenshots of the modified ovpn running at console:
> http://www.a-fa.de/am/ovpn/console_screenshot.gif
> 
> and running at the gui with the redirected pipes:
> http://www.a-fa.de/am/ovpn/gui_screenshot.gif
> 
> both times with the same config and the same key.
> 
> thanks for any help or information!
> 
> with greetings
> Andre
> 
> 
> The following is just informational:
> 
> The redirecting of the named pipes it done by the STARTUPINFO Structure of
> Windows used by the CreateProcess API Command:
> 
> typedef struct _STARTUPINFO { // si  
>     DWORD   cb; 
>     LPTSTR  lpReserved; 
>     LPTSTR  lpDesktop; 
>     LPTSTR  lpTitle; 
>     DWORD   dwX; 
>     DWORD   dwY; 
>     DWORD   dwXSize; 
>     DWORD   dwYSize; 
>     DWORD   dwXCountChars; 
>     DWORD   dwYCountChars; 
>     DWORD   dwFillAttribute; 
>     DWORD   dwFlags; 
>     WORD    wShowWindow; 
>     WORD    cbReserved2; 
>     LPBYTE  lpReserved2; 
>     HANDLE  hStdInput;   <--- there you can give pipes at windows
>     HANDLE  hStdOutput;  <--- there you give the pipes at windows
>     HANDLE  hStdError;   <--- there you give the pipes at windows
> 
> } STARTUPINFO, *LPSTARTUPINFO; 
> 
> and with this it is called, where you can give an STARTUPINFO to Windows
> 
> BOOL CreateProcess(
> 
>     LPCTSTR lpApplicationName, // pointer to name of executable module 
>     LPTSTR lpCommandLine, // pointer to command line string
>     LPSECURITY_ATTRIBUTES lpProcessAttributes,
>     	// pointer to process security attributes 
>     LPSECURITY_ATTRIBUTES lpThreadAttributes,
>     	// pointer to thread security attributes 
>     BOOL bInheritHandles, // handle inheritance flag 
>     DWORD dwCreationFlags, // creation flags 
>     LPVOID lpEnvironment, // pointer to new environment block 
>     LPCTSTR lpCurrentDirectory, // pointer to current directory name 
>     LPSTARTUPINFO lpStartupInfo, // pointer to STARTUPINFO 
>     LPPROCESS_INFORMATION lpProcessInformation
>       // pointer to PROCESS_INFORMATION
>    );
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




