MIME-Version: 1.0
References: <1580388208-26594-1-git-send-email-selva.nair@...277...>
 <1580488320-10224-1-git-send-email-selva.nair@...277...>
 <CAGyAFMVO_CUsL_-Wuws4tLnnQWvZCfra0c_=djUzg4XoqtNJcA@...278...>
In-Reply-To: <CAGyAFMVO_CUsL_-Wuws4tLnnQWvZCfra0c_=djUzg4XoqtNJcA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 3 Feb 2020 10:49:37 +0200
Message-ID: <CAGyAFMUovaKR+2UTZXmuBOm8NktYhU0oCa9d6a4ZhZrspmeVew@...278...>
Content-Type: multipart/alternative; boundary="000000000000785330059da80137"
Subject: Re: [Openvpn-devel] [PATCH v2] Swap the order of checks for
 validating interactive service user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000785330059da80137
Content-Type: text/plain; charset="UTF-8"

I am sorry, I have to retract my ACK.

When ValidateOptions is called first and config is non located in global
directory (Program Files),
service replies to gui via pipe with error message:

0x20000001
You have specified a config file location (client.xxx.ovpn relative to
C:\Users\lev\OpenVPN\config\client.xxx) that requires admin approval. This
error may be avoided by adding your account to the "OpenVPN Administrators"
group
(null)

This message is incorrect, since account is in admin group, we just haven't
checked that yet. When following check verifies that user indeed belongs to
the admin group, service runs openvpn and connection got established. By
some reasons, above error message is not read on the gui side. However, by
adding small delay to service code or a breakpoint, message reaches gui,
which displays an error.

While under normal circumstances it works, I believe it just works by
accident (error message is not read on gui side without delay on service
side). We need to move sending error message out of ValidateOptions.


ma 3. helmik. 2020 klo 10.23 Lev Stipakov (lstipakov@...277...) kirjoitti:

> Built and tested, works as specified.
>
> Acked-by: Lev Stipakov <lstipakov@...277...>
>


-- 
-Lev

--000000000000785330059da80137
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I am sorry, I have to retract my ACK=
.</div><div><br></div><div>When ValidateOptions is called first and config =
is non located in global directory (Program Files),</div><div>service repli=
es to gui via pipe with error message:</div><div><br></div><div>0x20000001<=
br>You have specified a config file location (client.xxx.ovpn relative to C=
:\Users\lev\OpenVPN\config\client.xxx) that requires admin approval. This e=
rror may be avoided by adding your account to the &quot;OpenVPN Administrat=
ors&quot; group<br>(null)<br></div><div><br></div><div>This message is inco=
rrect, since account is in admin group, we just haven&#39;t checked that ye=
t. When following check verifies that user indeed belongs to the admin grou=
p, service runs openvpn and connection got established. By some reasons, ab=
ove error message is not read on the gui side. However, by adding small del=
ay to service code or a breakpoint, message reaches gui, which displays an =
error.</div><div><br></div><div>While under normal circumstances it works, =
I believe=C2=A0it just works by accident (error message is not read on gui =
side without delay on service side). We need to move sending error message =
out of ValidateOptions.</div><div><br></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">ma 3. helmik. 2020 klo 10.23 Le=
v Stipakov (<a href=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>)=
 kirjoitti:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div dir=3D"ltr">Built and tested, works as specified.<div><br=
></div><div>Acked-by: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...1663...=
." target=3D"_blank">lstipakov@...277...</a>&gt;</div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">-Lev</div></div>

--000000000000785330059da80137--

