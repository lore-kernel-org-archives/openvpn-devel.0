MIME-Version: 1.0
In-Reply-To: <4DD5432E.7070003@...1114...>
References: <BANLkTimDEA004RuTcUBKDXPWffEWBo3-iw@...278...>
	<4DD54252.90405@...1114...>
	<4DD5432E.7070003@...1114...>
Date: Thu, 19 May 2011 12:23:25 -0400
Message-ID: <BANLkTikT3V_qvub7Jt7F5bfmOTmrZRsdNg@...278...>
From: "Matthew L. Creech" <mlcreech@...277...>
Subject: Re: [Openvpn-devel] [PATCH] fix 2.2.0 build failure when management
 interface disabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, May 19, 2011 at 12:19 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
>
> Sorry! =A0I need to revert this patch. =A0You use MANAGEMENT_ENABLED, but=
 it
> should be ENABLE_MANAGEMENT. =A0I just noticed it now. =A0I'm sorry for t=
he
> noise, I'll fix this and apply it again.
>

Oops, sorry about that!  Didn't notice it was wrong, since neither one
is defined for my build.  :)

Thanks David

--=20
Matthew L. Creech

