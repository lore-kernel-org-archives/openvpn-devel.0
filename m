Message-ID: <20686C579479DC438276A726FE80CDAA01BC18D3@...281...>
From: satinders@...280...
Subject: RE: [Openvpn-devel] Pass log and passphrase between OpenVPN and O
	penVPN GUI
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C4AB64.93047A40"
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
Date: Tue Oct  5 22:24:01 2004
To: openvpn-devel@lists.sourceforge.net

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C4AB64.93047A40
Content-Type: text/plain;
	charset="iso-8859-1"

Hi,
	Currently openvpn demands that in client-server scenario, private
IPs should not clash with other machines. What if a client with IP 10.19.0.5
sitting in an ISP network (e.g. internet cafe) is there and server tries to
assign 10.19.0.5 to this machine. Also there are other machines on 10.19.0.0
network on ISP side which client wants to access. In this scenario client
will not be able to access other 10.19.0.0. machines if openvpn is started.

Do we have any mechanism through which client can find out which 10.19.0.0
IP is free and then can send request to server to assign this specific IP to
me? And also it can set the routing itself.

If this is not the right group to post this type of query then kindly
suggest me the right one.

Regards,
Satinder

-----Original Message-----
From: James Yonan [mailto:jim@...41...]
Sent: Wednesday, October 06, 2004 2:45 AM
To: Mathias Sundman
Cc: Didier Conchaudron; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Pass log and passphrase between OpenVPN and
OpenVPN GUI


On Tue, 5 Oct 2004, Mathias Sundman wrote:

> So to summarize:
> 
> SW=Service Wrapper
> 
> 1. The SW should redirect stdin/stdout/stderr through a pipe.
> 
> 2. The SW will write everything arriving on stdout/stderr to a logfile.
> 
> 3. The SW will monitor stdout/stderr for password prompts, and when it 
> sees one it will send a query over the already established TCP session to 
> the GUI, which will respond with the password. The SW then passes this 
> back to openvpn over the pipe.

I agree that only one TCP connection between GUI and SW is appropriate, 
even when the SW is controlling multiple openvpn processes.

> Is there any security issues with this we need to consider?

I think there should be some sort of admin password which the SW will 
expect before it grants access to a GUI process connecting as a TCP client 
on the SW's local socket.

> 4. The GUI will have to monitor the accual log file on disk in order to be

> able to show the log in real-time. For this to work, it's important that 
> the SW flushes its write buffer to disk after every write.
> 
> Which is the best way of writing to a file, and making sure it's really 
> written to disk, on Windows?
>
> WriteFile(), fprintf(), fputs(), write()?

If you're using a FILE *, fflush() is usually sufficient.

I believe if you use native Win32 I/O such as WriteFile, the flush is 
immediate (not to say it physically goes to disk but rather that it is 
immediately available to another process which reads it.)

Another point:  Portability.  It would be nice to make a portable SW that 
would work on all the platforms that OpenVPN runs on.

James

> 
> On Tue, 5 Oct 2004, Didier Conchaudron wrote:
> 
> > Hi all,
> >
> > I agree with James for including several things such as monitoring 
> > stdin/out/err into the wrapper.
> >
> > But I'm not very ok for the idea of creating a socket for each
connection 
> > because our users will probably only use one GUI so this GUI may have to

> > discuss throught a unique socket to make things simpler. Now I agree
that 
> > they're problems when we run several tunnels. I think of a system where
each 
> > starting tunnel can ask, throught the same socket, a password or
user/pass 
> > data just by adding a header like:
> >
> > foo.ovpn: asking private key password
> > foo2.ovpn: asking extended auth. username
> >
> > This way the GUI will have to handle just one socket, it could be then 
> > simpler to add features to GUI, ITOA it's harder for wrapper to add
those.
> >
> > An other point is security. Actually the service wrapper need to run as 
> > SYSTEM/Admin rights, we have to limit the features and commands which
will 
> > run as SYSTEM.
> >
> > Didier
> >
> > James Yonan wrote:
> >> On Fri, 1 Oct 2004, Mathias Sundman wrote:
> >> 
> >> 
> >>> Didier announced a first release of an improved version of the OpenVPN

> >>> Service Wrapper earlier this week. The goal with this is to allow a
non 
> >>> admin user on Windows to start/stop openvpn processes.
> >>> 
> >>> It does this by listening on a local TCP socket for commands like
"START 
> >>> config.ovpn" or "STOP config.ovpn".
> >>> 
> >>> I've started working on OpenVPN GUI 2.0 that will use this service 
> >>> wrapper to control openvpn.
> >>> 
> >>> There is two things that remain unsolved though that I'd like to bring

> >>> up for some discussion.
> >>> 
> >>> 1. How do we pass the private key passphrase from the GUI to the
openvpn 
> >>> process?
> >>> 
> >>> 2. How do we get the openvpn log to the GUI so we can show it in real 
> >>> time in the status window?
> >>> 
> >>> 
> >>> I can see a couple of solutions:
> >>> 
> >>> A) We create a pipe between the openvpn process and the service
wrapper. 
> >>> The service can then watch the openvpn output for the passphrase
prompt, 
> >>> and pass on the request to the GUI over the TCP socket.
> >>> 
> >>> The log is then written to the log file by the service. The GUI will 
> >>> have to monitor this file for changes to be able to show the log in 
> >>> real-time.
> >>> 
> >>> 
> >>> B) We create another TCP socket for every launched process, and
creates 
> >>> a pipe between this socket and the openvpn process. The GUI can then 
> >>> connect to this socket to recieve the log in real-time, and can
monitor 
> >>> this for the passphrase prompt itself.
> >> 
> >> 
> >> I like the idea of having the service wrapper control the 
> >> stdin/stdout/stderr which is passed to the openvpn process, then have
it 
> >> send password(s) over stdin.
> >> 
> >> So the communication between the service wrapper and the openvpn
processes 
> >> would be via standard i/o handles and the communication between the 
> >> service wrapper and the GUI would be over the management socket.
> >> 
> >> That means the service wrapper would need to be a proxy of sorts,
passing 
> >> passwords and possibly log file output as well between the GUI and
openvpn 
> >> processes.
> >> 
> >> James
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

------_=_NextPart_001_01C4AB64.93047A40
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 5.5.2653.12">
<TITLE>RE: [Openvpn-devel] Pass log and passphrase between OpenVPN and Open=
VPN GUI</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi,</FONT>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT SIZE=3D2>Currently ope=
nvpn demands that in client-server scenario, private IPs should not clash w=
ith other machines. What if a client with IP 10.19.0.5 sitting in an ISP ne=
twork (e.g. internet cafe) is there and server tries to assign 10.19.0.5 to=
 this machine. Also there are other machines on 10.19.0.0 network on ISP si=
de which client wants to access. In this scenario client will not be able t=
o access other 10.19.0.0. machines if openvpn is started.</FONT></P>

<P><FONT SIZE=3D2>Do we have any mechanism through which client can find ou=
t which 10.19.0.0 IP is free and then can send request to server to assign =
this specific IP to me? And also it can set the routing itself.</FONT></P>

<P><FONT SIZE=3D2>If this is not the right group to post this type of query=
 then kindly suggest me the right one.</FONT>
</P>

<P><FONT SIZE=3D2>Regards,</FONT>
<BR><FONT SIZE=3D2>Satinder</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: James Yonan [<A HREF=3D"mailto:jim@...41...">mailt=
o:jim@...41...</A>]</FONT>
<BR><FONT SIZE=3D2>Sent: Wednesday, October 06, 2004 2:45 AM</FONT>
<BR><FONT SIZE=3D2>To: Mathias Sundman</FONT>
<BR><FONT SIZE=3D2>Cc: Didier Conchaudron; openvpn-devel@...290...=
net</FONT>
<BR><FONT SIZE=3D2>Subject: Re: [Openvpn-devel] Pass log and passphrase bet=
ween OpenVPN and</FONT>
<BR><FONT SIZE=3D2>OpenVPN GUI</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>On Tue, 5 Oct 2004, Mathias Sundman wrote:</FONT>
</P>

<P><FONT SIZE=3D2>&gt; So to summarize:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; SW=3DService Wrapper</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; 1. The SW should redirect stdin/stdout/stderr throu=
gh a pipe.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; 2. The SW will write everything arriving on stdout/=
stderr to a logfile.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; 3. The SW will monitor stdout/stderr for password p=
rompts, and when it </FONT>
<BR><FONT SIZE=3D2>&gt; sees one it will send a query over the already esta=
blished TCP session to </FONT>
<BR><FONT SIZE=3D2>&gt; the GUI, which will respond with the password. The =
SW then passes this </FONT>
<BR><FONT SIZE=3D2>&gt; back to openvpn over the pipe.</FONT>
</P>

<P><FONT SIZE=3D2>I agree that only one TCP connection between GUI and SW i=
s appropriate, </FONT>
<BR><FONT SIZE=3D2>even when the SW is controlling multiple openvpn process=
es.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Is there any security issues with this we need to co=
nsider?</FONT>
</P>

<P><FONT SIZE=3D2>I think there should be some sort of admin password which=
 the SW will </FONT>
<BR><FONT SIZE=3D2>expect before it grants access to a GUI process connecti=
ng as a TCP client </FONT>
<BR><FONT SIZE=3D2>on the SW's local socket.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; 4. The GUI will have to monitor the accual log file =
on disk in order to be </FONT>
<BR><FONT SIZE=3D2>&gt; able to show the log in real-time. For this to work=
, it's important that </FONT>
<BR><FONT SIZE=3D2>&gt; the SW flushes its write buffer to disk after every=
 write.</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Which is the best way of writing to a file, and mak=
ing sure it's really </FONT>
<BR><FONT SIZE=3D2>&gt; written to disk, on Windows?</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; WriteFile(), fprintf(), fputs(), write()?</FONT>
</P>

<P><FONT SIZE=3D2>If you're using a FILE *, fflush() is usually sufficient.=
</FONT>
</P>

<P><FONT SIZE=3D2>I believe if you use native Win32 I/O such as WriteFile, =
the flush is </FONT>
<BR><FONT SIZE=3D2>immediate (not to say it physically goes to disk but rat=
her that it is </FONT>
<BR><FONT SIZE=3D2>immediately available to another process which reads it.=
)</FONT>
</P>

<P><FONT SIZE=3D2>Another point:&nbsp; Portability.&nbsp; It would be nice =
to make a portable SW that </FONT>
<BR><FONT SIZE=3D2>would work on all the platforms that OpenVPN runs on.</F=
ONT>
</P>

<P><FONT SIZE=3D2>James</FONT>
</P>

<P><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; On Tue, 5 Oct 2004, Didier Conchaudron wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Hi all,</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; I agree with James for including several thing=
s such as monitoring </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; stdin/out/err into the wrapper.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; But I'm not very ok for the idea of creating a=
 socket for each connection </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; because our users will probably only use one G=
UI so this GUI may have to </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; discuss throught a unique socket to make thing=
s simpler. Now I agree that </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; they're problems when we run several tunnels. =
I think of a system where each </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; starting tunnel can ask, throught the same soc=
ket, a password or user/pass </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; data just by adding a header like:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; foo.ovpn: asking private key password</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; foo2.ovpn: asking extended auth. username</FON=
T>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; This way the GUI will have to handle just one =
socket, it could be then </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; simpler to add features to GUI, ITOA it's hard=
er for wrapper to add those.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; An other point is security. Actually the servi=
ce wrapper need to run as </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; SYSTEM/Admin rights, we have to limit the feat=
ures and commands which will </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; run as SYSTEM.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Didier</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; James Yonan wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; On Fri, 1 Oct 2004, Mathias Sundman wrote:=
</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; Didier announced a first release of an=
 improved version of the OpenVPN </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; Service Wrapper earlier this week. The=
 goal with this is to allow a non </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; admin user on Windows to start/stop op=
envpn processes.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; It does this by listening on a local T=
CP socket for commands like &quot;START </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; config.ovpn&quot; or &quot;STOP config=
.ovpn&quot;.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; I've started working on OpenVPN GUI 2.=
0 that will use this service </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; wrapper to control openvpn.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; There is two things that remain unsolv=
ed though that I'd like to bring </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; up for some discussion.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; 1. How do we pass the private key pass=
phrase from the GUI to the openvpn </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; process?</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; 2. How do we get the openvpn log to th=
e GUI so we can show it in real </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; time in the status window?</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; I can see a couple of solutions:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; A) We create a pipe between the openvp=
n process and the service wrapper. </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; The service can then watch the openvpn=
 output for the passphrase prompt, </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; and pass on the request to the GUI ove=
r the TCP socket.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; The log is then written to the log fil=
e by the service. The GUI will </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; have to monitor this file for changes =
to be able to show the log in </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; real-time.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; B) We create another TCP socket for ev=
ery launched process, and creates </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; a pipe between this socket and the ope=
nvpn process. The GUI can then </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; connect to this socket to recieve the =
log in real-time, and can monitor </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt;&gt; this for the passphrase prompt itself.=
</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; I like the idea of having the service wrap=
per control the </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; stdin/stdout/stderr which is passed to the=
 openvpn process, then have it </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; send password(s) over stdin.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; So the communication between the service w=
rapper and the openvpn processes </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; would be via standard i/o handles and the =
communication between the </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; service wrapper and the GUI would be over =
the management socket.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; That means the service wrapper would need =
to be a proxy of sorts, passing </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; passwords and possibly log file output as =
well between the GUI and openvpn </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; processes.</FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; &gt;&gt; James</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; ---------------------------------------------------=
----</FONT>
<BR><FONT SIZE=3D2>&gt; This SF.net email is sponsored by: IT Product Guide=
 on ITManagersJournal</FONT>
<BR><FONT SIZE=3D2>&gt; Use IT products in your business? Tell us what you =
think of them. Give us</FONT>
<BR><FONT SIZE=3D2>&gt; Your Opinions, Get Free ThinkGeek Gift Certificates=
! Click to find out more</FONT>
<BR><FONT SIZE=3D2>&gt; <A HREF=3D"http://productguide.itmanagersjournal.co=
m/guidepromo.tmpl" TARGET=3D"_blank">http://productguide.itmanagersjournal.=
com/guidepromo.tmpl</A></FONT>
<BR><FONT SIZE=3D2>&gt; _______________________________________________</FO=
NT>
<BR><FONT SIZE=3D2>&gt; Openvpn-devel mailing list</FONT>
<BR><FONT SIZE=3D2>&gt; Openvpn-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2>&gt; <A HREF=3D"https://lists.sourceforge.net/lists/list=
info/openvpn-devel" TARGET=3D"_blank">https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel</A></FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
</P>
<BR>

<P><FONT SIZE=3D2>-------------------------------------------------------</=
FONT>
<BR><FONT SIZE=3D2>This SF.net email is sponsored by: IT Product Guide on I=
TManagersJournal</FONT>
<BR><FONT SIZE=3D2>Use IT products in your business? Tell us what you think=
 of them. Give us</FONT>
<BR><FONT SIZE=3D2>Your Opinions, Get Free ThinkGeek Gift Certificates! Cli=
ck to find out more</FONT>
<BR><FONT SIZE=3D2><A HREF=3D"http://productguide.itmanagersjournal.com/gui=
depromo.tmpl" TARGET=3D"_blank">http://productguide.itmanagersjournal.com/g=
uidepromo.tmpl</A></FONT>
<BR><FONT SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Openvpn-devel mailing list</FONT>
<BR><FONT SIZE=3D2>Openvpn-devel@lists.sourceforge.net</FONT>
<BR><FONT SIZE=3D2><A HREF=3D"https://lists.sourceforge.net/lists/listinfo/=
openvpn-devel" TARGET=3D"_blank">https://lists.sourceforge.net/lists/listin=
fo/openvpn-devel</A></FONT>
</P>

</BODY>
</HTML>=

------_=_NextPart_001_01C4AB64.93047A40--

