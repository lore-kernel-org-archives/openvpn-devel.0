MIME-Version: 1.0
From: Nelson Teixeira <nelson777@...277...>
Date: Thu, 13 Sep 2012 10:10:53 -0300
Message-ID: <CAGsOL8+F=7AtU_7wa5KpA-8q87Jm+GN5ncPqn3K7FVfXryV7SQ@...278...>
Content-Type: multipart/alternative; boundary=f46d040168c7814aa604c9950b6f
Subject: [Openvpn-devel] openvpn-gui disconnect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f46d040168c7814aa604c9950b6f
Content-Type: text/plain; charset=ISO-8859-1

Hello,

Sorry by writting directly to devel list, but I'm not being able to solve
this problem I'm in and thought maybe you would be so kind to take a look.
Thanks in advance :)

I'm having trouble in finding how to end openvpn programmatically in
windows. If I run openvpn in command line, I can end it graciously with F4.
What I want to do is to make my python program (or batch file/executable
program, can be in C/C++) do the same thing: end it gracioulsy, allow for
openvpn to do it's cleanup tasks.
Yet the only thing available to stop the process is taskkill /F /PID
<PID_NUMBER> that ends it immediately without allowing openvpn to do it's
cleanup tasks. If I don't use /F switch, it just ignores the command. I
tried  also with /T (Tree Kill). No luck.
I also tried to get openvpn pid and send it a signal using this python code
(it's python but it's easily understandable by anyone:

import ctypes
PROCESS_TERMINATE = 33
handle = ctypes.windll.kernel32.
OpenProcess(PROCESS_TERMINATE, False, <PID>)
ctypes.windll.kernel32.TerminateProcess(handle, -1)
ctypes.windll.kernel32.CloseHandle(handle)

I tried all signals ranging from 0 to 33. None did the job. Some are
plainly ignored, some terminate the processe forcefully.

A colleague of mine remembered that openvpn-gui does it the right way. I'm
also a c/C++ programmer, so I grab the source-code and try to find how it
does the trick, but I find it's a bit more hidden than I thought.
As far as I understood, the disconnect button calls the StopOpenVPN
funcion, which sets the o.cnn[config].connect_status field to DISCONNECT*ING
* and WatchOpenVPNProcess function tracks it and then disconnects. But if
i'm groking this right, the only thing it does besides setting
connect_status to DISCONECT*ED* is the following command:

     SendMessage(o.cnn[config].hwndStatus, WM_CLOSE, 0, 0);

Just closing the window, finishes it graciously ? why ? Am I missing the
point here ? Can you please tell me how you do the trick ?
If anyone else has some idea, I'll love to read it.

Thanx,
-Nelson

--f46d040168c7814aa604c9950b6f
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>Sorry by writting directly to devel list, but I&#39;m not bei=
ng able to solve this problem I&#39;m in and thought maybe you would be so =
kind to take a look. Thanks in advance :)<br>
<br>
I&#39;m having trouble in finding how to end openvpn programmatically in wi=
ndows.
If I run openvpn in command line, I can end it graciously with F4.
What I want to do is to make my python program (or batch file/executable pr=
ogram, can be in C/C++) do the same
thing: end it gracioulsy, allow for openvpn to do it&#39;s cleanup tasks.<b=
r>Yet the only thing available to stop the process is taskkill /F /PID
&lt;PID_NUMBER&gt; that ends it immediately without allowing openvpn to do =
it&#39;s=A0
cleanup tasks. If I don&#39;t use /F switch, it just ignores the command. I=
 tried=A0
also with /T (Tree Kill). No luck.<br>
I also tried to get openvpn pid and send it a signal using this python code=
 (it&#39;s python but it&#39;s easily understandable by anyone:<br>
<br>
import ctypes<br>
PROCESS_TERMINATE =3D 33<br>
handle =3D ctypes.windll.kernel32.<div>OpenProcess(PROCESS_TERMINATE, False=
, &lt;PID&gt;)<br>
ctypes.windll.kernel32.TerminateProcess(handle, -1)<br>
ctypes.windll.kernel32.CloseHandle(handle)<br>
<br>
I tried all signals ranging from 0 to 33. None did the job. Some are plainl=
y ignored, some terminate the processe forcefully.<br>
<br>
A colleague of mine remembered that openvpn-gui does it the right way. I&#3=
9;m also a c/C++ programmer, so I grab the source-code and try to find how =
it does the
trick, but I find it&#39;s a bit more hidden than I thought.<br>As far as I=
 understood, the disconnect button calls the StopOpenVPN funcion, which set=
s the o.cnn[config].connect_status field to DISCONNECT<b>ING</b> and=20
WatchOpenVPNProcess function tracks it and then disconnects. But if i&#39;m=
 groking this right, the only thing it does besides setting connect_status =
to DISCONECT<b>ED</b> is the following command:<br>
<br>=A0=A0=A0=A0 SendMessage(o.cnn[config].hwndStatus, WM_CLOSE, 0, 0);<br>=
<br>Just closing the window, finishes it graciously ? why ? Am I missing th=
e point here ?
Can you please tell me how you do the trick ?<br>
If anyone else has some idea, I&#39;ll love to read it.<br>
<br>
Thanx,<br>
-Nelson</div>

--f46d040168c7814aa604c9950b6f--

