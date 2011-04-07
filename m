MIME-Version: 1.0
In-Reply-To: <4D9DB2AE.2080907@...1347...>
References: <1302106222-10256-1-git-send-email-davids@...1347...>
	<BANLkTik3QGpmced2mqhxDv6cmNJDZcxFMw@...278...>
	<4D9DB2AE.2080907@...1347...>
Date: Thu, 7 Apr 2011 17:04:44 +0300
Message-ID: <BANLkTin837cp5Z1vUYTak_Wx3MDUbEHJrw@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a
 more suitable path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 7, 2011 at 3:48 PM, David Sommerseth <davids@...1347...> wrote:
> Good idea! =C2=A0I wasn't aware of that one. =C2=A0I'll fix this. =C2=A0I=
 will anyway
> choose to fallback to C:\WINDOWS\Temp if %SystemRoot% is not found, even
> though I believe this is most likely not something which should happen.

Can't happen, Windows will not boot.

> I'll implement the suggested change for autotools as well and propose an
> additional patch to cover your comments.

I really think you should remove this from compile time (autoconf). It
is useless, users can override it anyway in configuration, so there is
no need for this.

