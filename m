MIME-Version: 1.0
In-Reply-To: <CAP+U6tJ-f9NHPCYU3H08ub2uiNhy2=ubkFXmP=fcoq0B8EptLQ@...278...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-36-git-send-email-alon.barlev@...277...>
	<4F588784.300@...515...>
	<CAOazyz3OzNYscLd01QY_wopFkH9zctixQNhJr-PyoPmTBvrwTw@...278...>
	<CAP+U6tJx_xNbEHfhENcJKEpgE1WMf-03ez=nKo2zEwUQEEe7Xw@...278...>
	<CAOazyz2ESjg4vbYRqaCcT4PGdnQKw3Y77kS9UsTi2OD+_mXoSw@...278...>
	<CAP+U6tJ-f9NHPCYU3H08ub2uiNhy2=ubkFXmP=fcoq0B8EptLQ@...278...>
Date: Fri, 16 Mar 2012 18:34:42 +0200
Message-ID: <CAOazyz2DZXU1m41NZ_a9==qcwKku8_xTfzSHifHJYL9Yj-B7aA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 35/52] build: proper selinux detection
	and usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Fri, Mar 16, 2012 at 6:29 PM, Fabian Knittel
<fabian.knittel@...1547...> wrote:
> So it sounds as if we're actually somewhat in agreement! You don't
> want complex, automatic detection of non-standard situations and I
> agree wholeheartedly.
> But I _do_ want basic checking to achieve clear error messages at
> configuration time, not obscure build errors far later in the build
> process. Rule of thumb: If "make" fails due to missing or wrong
> dependencies, it's a bug in configure, because it didn't detect the
> problem beforehand.

I understand your argument.
However, from my experience it is not needed, people are most capable
of manage this without creating noise.
I suggest to leave this as-is and if for some reason the audience of
openvpn is different than other project I handle, we modify it.

Alon.

