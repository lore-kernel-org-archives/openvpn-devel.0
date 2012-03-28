MIME-Version: 1.0
In-Reply-To: <2923473.VmpqgqZo5Q@...1526...>
References: <1330546942-18250-1-git-send-email-alon.barlev@...277...>
	<2923473.VmpqgqZo5Q@...1526...>
Date: Wed, 28 Mar 2012 13:55:01 +0200
Message-ID: <CAOazyz35uT3nK=93mLzVewNO8q9p_uDtsQcGVbeLT3R3zg+W3w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [openvpn-gui 0/8] build rewrite
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

On Wed, Mar 28, 2012 at 1:13 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Hi Alon.

Hello,

>> =C2=A0 build: rework build
>
> Removed use of libtool and the implicit automake rule for .rc files. Inst=
ead
> add a manual rule for the resource object to Makefile.am.

Not sure why you guys have issues with libtool.
There are people out there that invest time, resources and knowledge
to make things work, without us need to worry about the implications
or implementation.
libtool supports windows resources build in proper way easy to use,
the price is just having libtool around.
I really do not understand why not to use it.

Anyway, I had some more cleanups in my branch and fixups to the latest
changes, I am submitting it now.

Alon.

