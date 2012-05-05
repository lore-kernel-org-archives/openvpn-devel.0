MIME-Version: 1.0
In-Reply-To: <1336199983-9916-1-git-send-email-alon.barlev@...277...>
References: <CAOazyz2X_E=ODTGZ2mu-1Q1NkF4DaM=jLPoiKsDXmJ9KN3tZ6Q@...278...>
	<1336199983-9916-1-git-send-email-alon.barlev@...277...>
Date: Sat, 5 May 2012 09:41:20 +0300
Message-ID: <CAOazyz3AxqqWy6s_R0vN3EZuXtfpQ7bcV-=Srs12w39tdyMhqA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] build: add git revision to
 --version output if build from git repository
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
To: openvpn-devel@lists.sourceforge.net

On Sat, May 5, 2012 at 9:39 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> If source is located at git repository, acquire branch and revision
> of head to be printed at --version output.
>
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>

Exactly the same patch, just renamed the variable
CONFIGURE_GIT_REVISION to be consistent with next patch and previous
configure defs constant name.

Alon.

