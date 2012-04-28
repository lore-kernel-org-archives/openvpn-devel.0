MIME-Version: 1.0
In-Reply-To: <1335636013-7717-1-git-send-email-alon.barlev@...277...>
References: <1335636013-7717-1-git-send-email-alon.barlev@...277...>
Date: Sat, 28 Apr 2012 21:03:04 +0300
Message-ID: <CAOazyz3nLQ1zO3sBMdVm=qbu2Yw54kys=qMUty_fTgeCe7QaEA@...278...>
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
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn.list@...1114...>

On Sat, Apr 28, 2012 at 9:00 PM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> If configure is located at git repository, acquire branch and revision
> of head to be printed at --version output.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
> =C2=A0configure.ac =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 11 ++++++++=
+++
> =C2=A0src/openvpn/options.c | =C2=A0 =C2=A03 +++
> =C2=A02 files changed, 14 insertions(+), 0 deletions(-)

David,

Check if this meets your requirement.
It won't survive make dist, but if compiled directly from repository
the HEAD will be visible.
Surviving make dist is doable if some file is generated, but this file
will stay the same even if there are local modifications... So I don't
think it worth both the effort and the confusion.

Alon.

