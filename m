MIME-Version: 1.0
In-Reply-To: <OpenVPN/openvpn-gui/issues/92@...1714...>
References: <OpenVPN/openvpn-gui/issues/92@...1714...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 3 Nov 2016 20:36:56 -0400
Message-ID: <CAKuzo_gpuqnpz1T2ZYDPfPHM=6ebj+yMawtZykUus08rB42seA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06cdea45dd2e05406ee0a6
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] OpenVPN & pam_radius_auth
	- Dynamic CR (#92)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: OpenVPN/openvpn-gui <reply+003cc04ff0501128fbc74d0c08d2fd1c39bbe1be78c9b86292cf000000011433890392a169ce0b28b258@...1858...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06cdea45dd2e05406ee0a6
Content-Type: text/plain; charset=UTF-8

Hi,

Copying openvpn-devel as this is more about openvpn server than the GUI.

On Thu, Nov 3, 2016 at 7:23 PM, roberthunt-dm <notifications@...1714...>
wrote:

> I am trying to get OpenVPN working with a Radius server configured to send
> an access_challenge for an otp code it dynamically generates.
>
> (server) openvpn server 2.3.2-7ubuntu3.1
> (client) Openvpn-gui-cr.exe
>
The big question mark for me is how pam_radius_auth interacts with Openvpn.
>
> Logs show that the plugin is receiving the code 11 access_challenge from
> the radius server:
>
> Nov 3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got user name
> xxxxxx
> Nov 3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Sending RADIUS
> request code 1
> Nov 3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got RADIUS
> response code 11
> Nov 3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got response to
> challenge code 11
> Nov 3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got response to
> challenge code 3
> Nov 3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: authentication
> failed
>
> However I don't see any pop-up box on the OpenVPN client prompting for the
> OTP code.
>

You have to send the authentication failed message with a specially
formatted reason back to the client. For example. reason =
CRV1:R,E:some_id:base64_username:Input OTP code will cause the server to
send AUTH_FAILED followed by that reason back to the client. The client
will then prompt for a second round of authentication and the GUI will
parse the failure reason and prompt for OTP.

Client log will show what kind of AUTH_FAILED message is received from the
server.

For details of the message format see "Challenge/Response protocol"
description here: https://openvpn.net/index.php/
open-source/documentation/miscellaneous/79-management-interface.html

> On the radius server, for the 2nd access request message (in response to
> the access_challenge) - openvpn is just sending the same original
> access_request message. The radius server then rejects access.
>
> Do I need to modify pam_radius_auth to send messages in a special format
> to openvpn? I'm using this from here: https://github.com/FreeRADIUS/
> pam_radius/blob/master/src/pam_radius_auth.c
>
As far as I know the only way to send back a specially crafted reason for
auth failure is using the management interface for authentication
(--management-client-auth in the server config). But I don't know enough
about the plugin api to know if and how this could be achieved using a
plugin.

Selva

--94eb2c06cdea45dd2e05406ee0a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra">Copying openvpn-devel as this is more about openvpn server tha=
n the GUI.<br><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quot=
e">On Thu, Nov 3, 2016 at 7:23 PM, roberthunt-dm <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:notifications@...1714..." target=3D"_blank">notifications@...493...=
1714...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><p>I am trying to get OpenVPN working with a Radius server configur=
ed to send an access_challenge for an otp code it dynamically generates.</p>
<p>(server) openvpn server 2.3.2-7ubuntu3.1<br>
(client)  Openvpn-gui-cr.exe <br></p></blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<p>The big question mark for me is how pam_radius_auth interacts with Openv=
pn.</p>
<p>Logs show that the plugin is receiving the code 11 access_challenge from=
 the radius server:</p>
<p>Nov  3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got user name x=
xxxxx<br>
Nov  3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Sending RADIUS req=
uest code 1<br>
Nov  3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got RADIUS respons=
e code 11<br>
Nov  3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got response to ch=
allenge code 11<br>
Nov  3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: Got response to ch=
allenge code 3<br>
Nov  3 15:30:21 openvpn openvpn[10910]: pam_radius_auth: authentication fai=
led</p>
<p>However I don&#39;t see any pop-up box on the OpenVPN client prompting f=
or the OTP code.</p></blockquote><div><br></div><div>You have to send the a=
uthentication failed message with a specially formatted reason back to the =
client. For example. reason =3D CRV1:R,E:some_id:base64_userna<wbr>me:Input=
 OTP code will cause the server to send AUTH_FAILED followed by that reason=
 back to the client. The client will then prompt for a second round of auth=
entication and the GUI will parse the failure reason and prompt for OTP. <b=
r><br>Client log will show what kind of AUTH_FAILED message is received fro=
m the server.<br><br>For details of the message format see &quot;Challenge/=
Response protocol&quot; description here: <a href=3D"https://openvpn.net/in=
dex.php/open-source/documentation/miscellaneous/79-management-interface.htm=
l" target=3D"_blank">https://openvpn.net/index.php/<wbr>open-source/documen=
tation/misc<wbr>ellaneous/79-management-interf<wbr>ace.html</a><br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<p>On the radius server, for the 2nd access request message (in response to=
 the access_challenge) - openvpn is just sending the same original access_r=
equest message.  The radius server then rejects access.</p>
<p>Do I need to modify pam_radius_auth to send messages in a special format=
 to openvpn?    I&#39;m using this from here:  <a href=3D"https://github.co=
m/FreeRADIUS/pam_radius/blob/master/src/pam_radius_auth.c" target=3D"_blank=
">https://github.com/FreeRADIUS/<wbr>pam_radius/blob/master/src/pam<wbr>_ra=
dius_auth.c</a></p></blockquote></div>As far as I know the only way to send=
 back a specially crafted reason for auth failure is using the management i=
nterface for authentication (--management-client-auth in the server config)=
. But I don&#39;t know enough about the plugin api to know if and how this =
could be achieved using a plugin.<br></div><div class=3D"gmail_extra"><br><=
/div><div class=3D"gmail_extra">Selva<br></div></div>

--94eb2c06cdea45dd2e05406ee0a6--

