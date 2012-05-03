Message-ID: <4FA2ECBD.4070601@...1114...>
Date: Thu, 03 May 2012 22:38:21 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4FA239AB.4080308@...1114...>
	<1336070984-20803-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336070984-20803-1-git-send-email-alon.barlev@...277...>
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
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/05/12 20:49, Alon Bar-Lev wrote:
> If source is located at git repository, acquire branch and
> revision of head to be printed at --version output.
> 
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> --- Makefile.am
> |   25 ++++++++++++++++++++++++- configure.ac          |   11
> +++++++++++ src/openvpn/options.c |    6 ++++++ 3 files changed, 41
> insertions(+), 1 deletions(-)

Just a detail ... but isn't config-version.h.in lacking?  Haven't
tested it yet, just read through the patch - so I might have
overlooked something.

But this looks far closer to what I'd like from such a feature.
Thanks for poking into this!


kind regards,

David Sommerseth

