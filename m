MIME-Version: 1.0
In-Reply-To: <1302187927.31738.5@...1207...>
References: <4D9DB36B.3010202@...1114...>
	<1302187927.31738.5@...1207...>
Date: Thu, 7 Apr 2011 17:59:51 +0300
Message-ID: <BANLkTimg10mA1h5Nq58CsXcRqosP35t5TA@...278...>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Apr 7, 2011 at 5:52 PM, Karl O. Pinc <kop@...1206...> wrote:
> FYI After poking about the man pages of various Un*xs I find:
>
> login(1) does not have to set $TMPDIR, although the whole
> login process can be configured to do so there's no
> requirement that $TMPDIR exist.

This is so strange discussion.
OKOKOKOKOKOK there is no TMPDIR so you fallback to /tmp
What's wrong with that?
/tmp exists in POSIX and it is totally valid.
If system need to override this it declares the TMPDIR globally.
Please stop trying to find problems where not exist.

