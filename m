From: Stefan Monnier <monnier@...1268...>
Message-ID: <jwvty94e087.fsf-monnier+INBOX@...1269...>
References: <4E4B873F.6080009@...515...>
	<1313652334-15914-1-git-send-email-samuli@...515...>
	<4E575276.80206@...1114...> <4E576922.8010209@...515...>
Date: Fri, 26 Aug 2011 10:07:00 -0400
In-Reply-To: <4E576922.8010209@...515...> ("Samuli
	\=\?iso-8859-1\?Q\?Sepp\?\=
	\=\?iso-8859-1\?Q\?\=E4nen\=22's\?\= message of
	"Fri, 26 Aug 2011 12:36:34 +0300")
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
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> There shouldn't be a difference, I did quite a bit of Googling just to
> be sure. For example, the Dash shell seems to be used often as
> POSIX-compliance reference implementation. From

POSIX mandates $() so any posix shell will support it.  The issue is
with non-POSIX shells, if you do want to support them (e.g. Solaris's
/bin/sh).


        Stefan

