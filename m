MIME-Version: 1.0
In-Reply-To: <1336112097-3043-1-git-send-email-alon.barlev@...277...>
References: <CAOazyz00YYGEpLTe3t3Rt9+mDU+tSbEvXwXbJKbmnZBiB0fQ6Q@...278...>
	<1336112097-3043-1-git-send-email-alon.barlev@...277...>
Date: Fri, 4 May 2012 09:17:11 +0300
Message-ID: <CAOazyz2X_E=ODTGZ2mu-1Q1NkF4DaM=jLPoiKsDXmJ9KN3tZ6Q@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] build: add git revision to --version
 output if build from git repository
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
To: openvpn-devel@lists.sourceforge.net

On Fri, May 4, 2012 at 9:14 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> If source is located at git repository, acquire branch and revision
> of head to be printed at --version output.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0.gitignore =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
1 +
> =C2=A0Makefile.am =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 21 ++++++++=
+++++++++++++
> =C2=A0compat.m4 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
5 +++++
> =C2=A0config-version.h.in =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 12 ++++++++=
++++
> =C2=A0src/openvpn/options.c | =C2=A0 =C2=A06 ++++++
> =C2=A06 files changed, 46 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 config-version.h.in

David,
This should be complete, even simpler than the original.
Alon.

