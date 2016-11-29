References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
	<CA+0EDdBLaPxX3u07yfg=S-xnVEnFRP7oD=2BnpONtjw7EEkPeQ@...278...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <331bcfe6-0373-1542-cdfc-50f360b7ceaa@...1435...>
Date: Tue, 29 Nov 2016 09:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <CA+0EDdBLaPxX3u07yfg=S-xnVEnFRP7oD=2BnpONtjw7EEkPeQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 29-11-16 00:00, Zhaomo Yang wrote:
> Just wanted to let you know that we have a new implementation of
> secure_memzero.h, which is available at 
> https://compsec.sysnet.ucsd.edu/secure_memzero.h
> <https://compsec.sysnet.ucsd.edu/secure_memzero.h>.
> 
> The version I sent to you guys has a minor issue in dealing with
> memset_s. Also, this implementation synthesizes most of the existing
> working solutions for this problem.  It allows you to specify, via
> macros, which implementation you prefer. This will let users override
> our defaults, if they want.

Thanks, but I think I prefer the more light-weight approach you sent
earlier (slightly molded to use static inline wrapper functions instead
of macro's).  It does what it needs to do for us, and is sufficiently
small to easily integrate into existing code.

And thanks again for notifying us (on security@) on your findings.

-Steffan


