Date: Thu, 21 Apr 2022 16:20:14 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <247712774.131939.1650550814513@...2642...>
In-Reply-To: <20220421135846.2465503-1-heiko@...2662...>
References: <20220420233148.2384208-1-heiko@...2662...>
 <20220421135846.2465503-1-heiko@...2662...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Add git pre-commit hook script to
 uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Heiko Hund <heiko@...2662...>, openvpn-devel@lists.sourceforge.net


> Heiko Hund <heiko@...2662...> hat am 21.04.2022 15:58 geschrieben:
[...]
> +ROOTDIR=$(git rev-parse --show-toplevel)
> +
> +# If called so, install this script as pre-commit hook
> +if [ "$1" = "install" ] ; then
> +    HOOKSDIR="$ROOTDIR/$(git rev-parse --git-path hooks)"

Hmm, no. While in a default install $(git rev-parse --git-path hooks) will
be a relative path, there is not guarantee that it is (e.g. if core.hooksPath
is an absolute path). I see not reason why you need an absolute path
here. A relative path should be completely fine?

Apart from this, the script seems to work fine and the licensing issue is
fixed.

Regards,
--
Frank Lichtenheld

