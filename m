From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0411082202130.8879@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN GUI not working with ms cert store
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
Date: Mon Nov  8 13:55:49 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I got an email from an OpenVPN GUI user today saying that it didn't work 
together with passphrase protected keys in the MS certificate store.

I had no problem reproducing it. I'm using OpenVPN 2.0-beta16, and all 
version of OpenVPN GUI from beta1 to beta22 fails.

What happends is that OpenVPN "hangs" when windows is supposed to show the 
dialog asking the user to enter his passphrase.

If openvpn is run from cmd-line it works fine, and the passphrase dialog 
is showed, and even Michael's .NET based GUI works!

But not mine ;-( For some reason the dialog is just not showed, so 
obviously openvpn can't continue.

I just can't see really why, so there for I ask here if anyone got a clue 
why that would fail?

My guesses are:

1. I do something wrong when launching OpenVPN with CreateProcess().

2. Windows has found that the GUI started the openvpn process and is 
sending some message that I need to respone to in a certain way, that .NET 
handles internally which would explain why Michael's GUI works, but not 
mine.


To ease debugging we can use OpenVPN GUI 1.0-beta1 as referance. It is 
almost a copy of the openvpn service wrapper, with just some code to show 
the tray icon and a basic windows message loop.

Here is how I lauch the openvpn process:

/* fill in STARTUPINFO struct */
GetStartupInfo(&start_info);
start_info.cb = sizeof(start_info);
start_info.dwFlags = STARTF_USESTDHANDLES|STARTF_USESHOWWINDOW;
start_info.wShowWindow = SW_HIDE;
start_info.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
start_info.hStdOutput = start_info.hStdError = log_handle;

/* create an OpenVPN process for one config file */
if (!CreateProcess(exe_path,
      command_line,
      NULL,
      NULL,
      TRUE,
      priority | CREATE_NEW_CONSOLE,
      NULL,
      config_dir,
      &start_info,
      &proc_info))
   {
     ERR ("CreateProcess failed, exe='%s' cmdline='%s' dir='%s'",
       exe_path,
       command_line,
       config_dir);

     FindClose (find_handle);
     CloseHandle (log_handle);
     goto finish;
   }


and here is my windows message callback function:

LRESULT CALLBACK WindowProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
   switch (message) {
     case WM_CREATE:
       TRAY_Init(hwnd); 		// Create tray icon and popup menu
       ShowTrayIcon();
       break;

     case WM_NOTIFYICONTRAY:
       OnNotifyTray(lParam); 	// Manages message from tray
       return TRUE;

     case WM_COMMAND:
       switch(LOWORD(wParam)) {
         case IDM_CONNECT:
           StartOpenVPN();
           break;
         case IDM_DISCONNECT:
           StopOpenVPN();
           break;
         case IDM_CLOSE:
           SendMessage(hwnd, WM_CLOSE, 0, 0);
           break;
       }
       break;

     case WM_DESTROY:
       StopOpenVPN();
       OnDestroyTray();          // Clean Tray related
       PostQuitMessage (0);	// Send a WM_QUIT to the message queue
       break;
     default:			// for messages that we don't deal with
       return DefWindowProc (hwnd, message, wParam, lParam);
   }

   return 0;
}

Best Regards,

Mathias

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


