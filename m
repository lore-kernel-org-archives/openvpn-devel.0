From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvd3fl7oxm.fsf-monnier+INBOX@...1269...>
References: <4E4B873F.6080009@...515...>
	<1313652334-15914-1-git-send-email-samuli@...515...>
	<4E575276.80206@...1114...> <4E576922.8010209@...515...>
	<jwvty94e087.fsf-monnier+INBOX@...1269...>
	<20110829140648.GU8496@...1296...> <4E5DCD83.9080507@...515...>
	<4E5DFF88.70701@...1114...>
Date: Wed, 31 Aug 2011 08:22:31 -0400
In-Reply-To: <4E5DFF88.70701@...1114...> (David Sommerseth's message of
	"Wed, 31 Aug 2011 11:31:52 +0200")
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Added whitespace handling for
	$KEY_CONFIG variable in easy-rsa/2.0/vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> ACK!  That makes sense to me.  But it needs to be clearly visible in some
> kind of requirements list.  If we don't have that, that's probably
> something we should have.

You could even start your shell scripts with something like:

test "x$(pwd)" = "x`pwd`" || (echo "This shell is not good enough"; exit 1)


        Stefan

