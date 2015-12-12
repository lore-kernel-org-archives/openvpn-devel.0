MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 12 Dec 2015 00:35:54 -0500
Message-ID: <CAKuzo_jkUeavm3QUZj52UUvqX9VK0PO-0PWxxJaoCnpyCuA5eQ@...278...>
Content-Type: multipart/alternative; boundary=001a1142b97a74e60e0526acd19e
Subject: [Openvpn-devel] On defaulting the GUI to run as administrator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1142b97a74e60e0526acd19e
Content-Type: text/plain; charset=UTF-8

continuing from the -users list thread
Ref: http://thread.gmane.org/gmane.network.openvpn.user/36387/focus=36417

Hi,

I have posted a pull request to openvpn-gui with a one line patch. It just
requests the highest Privilege from invoking user, and leaves the manifest
embedded. This means, when an admin user runs the GUI it will start with
full admin privileges, no change in behaviour for non-admin users.

Assuming a vast majorty of windows users work with admin accounts,
this may be enough to avoid most complaints that result from UAC
preventing elevation by default.

I'm reluctantly open to change this to "requireAdministrator" with
external manifest (just a small xml file that accompany the .exe).
Even with an external manifest it is not without issues. Such a GUI
will be unusable for any "limited user" who has no access to
admin credentials -- until an admin fixes it by editing the manifest,, .

Any strong voices out there? Comments from those who support
a large windows user base would be especially helpful.

On a related, note, currently the GUI shows no error when routes
are not setup (most often due to lack of privileges, I presume). This
could be improved if the management interface reports something
more useful than "CONNECTED,SUCCESS" as the state after route
setup errors. Then the GUI can be made to pop up a message
alerting the user. The alternative of parsing route errors from the
log is hard and error-prone.

Selva

--001a1142b97a74e60e0526acd19e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>continuing from the -users list thread<br>R=
ef: <a href=3D"http://thread.gmane.org/gmane.network.openvpn.user/36387/foc=
us=3D36417">http://thread.gmane.org/gmane.network.openvpn.user/36387/focus=
=3D36417</a><br><br></div><div>Hi,<br><br></div>I have posted a pull reques=
t to openvpn-gui with a one line patch. It just <br>requests the highest Pr=
ivilege from invoking user, and leaves the manifest<br>embedded. This means=
, when an admin user runs the GUI it will start with <br>full admin privile=
ges, no change in behaviour for non-admin users.<br><br></div><div>Assuming=
 a vast majorty of windows users work with admin accounts, <br>this may be =
enough to avoid most complaints that result from UAC <br>preventing elevati=
on by default.<br></div><div><br></div></div><div>I&#39;m reluctantly open =
to change this to &quot;requireAdministrator&quot; with <br>external manife=
st (just a small xml file that accompany the .exe). <br>Even with an extern=
al manifest it is not without issues. Such a GUI <br>will be unusable for a=
ny &quot;limited user&quot; who has no access to <br>admin credentials -- u=
ntil an admin fixes it by editing the manifest,, .<br><br>Any strong voices=
 out there? Comments from those who support<br>a large windows user base wo=
uld be especially helpful.<br></div><div><br></div><div>On a related, note,=
 currently the GUI shows no error when routes <br>are not setup (most often=
 due to lack of privileges, I presume). This <br>could be improved if the m=
anagement interface reports something <br>more useful than &quot;CONNECTED,=
SUCCESS&quot; as the state after route <br>setup errors. Then the GUI can b=
e made to pop up a message <br>alerting the user. The alternative of parsin=
g route errors from the <br>log is hard and error-prone.<br><br></div><div>=
Selva<br></div></div>

--001a1142b97a74e60e0526acd19e--

