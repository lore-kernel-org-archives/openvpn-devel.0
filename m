MIME-Version: 1.0
In-Reply-To: <7880280.vOpaqr0gUp@...1526...>
References: <1323280731-26083-1-git-send-email-heiko.hund@...1489...>
	<7880280.vOpaqr0gUp@...1526...>
Date: Thu, 8 Dec 2011 14:27:55 +0200
Message-ID: <CAOazyz00fbv7bFWc+H0uSk2U4RJdpyT97fov+O7bxRFaWuXoUA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] handle Windows unicode paths
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
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Dec 8, 2011 at 1:06 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> On Wednesday 07 December 2011 17:58:51 Heiko Hund wrote:
>> This patch makes openvpn read the command line in UCS-2 and convert
>> it to UTF-8 internally. Windows stores names in the filesystem in UCS-2.
>> When using a paths openvpn converts it from UTF-8 to UCS-2 and uses the
>> wide character Windows API function.
>
> One thing I left out on purpose for now was handling --capath with a Unic=
ode
> path. To have that work, openvpn would need to define a custom =C2=A0LOOK=
UP_METHOD
> that is Unicode-safe. The one that is currently used is at [1]. The probl=
em
> here is the _stat call that needs to be _wstat. Please let me know if tha=
t's
> something that should be done or not and I'll provide a patch.
>
> Heiko
>
> [1] http://cvs.openssl.org/fileview?f=3Dopenssl/crypto/x509/by_dir.c&v=3D=
1.32

Personally, I think that you should split this loooong patch into several.
Style changes, file io, openssl, etc...
For the openssl, I would split each change:dn, files.

It would be much easier to review and comment.

At first glance, the files are relatively ok.

Alon.

