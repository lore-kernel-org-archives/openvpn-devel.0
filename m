From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] mssfix option changed its behaviour
In-Reply-To: <20041117114417.GC1675@...30...>
Message-ID: <Pine.LNX.4.58.0411180422140.6079@...41...>
References: <20041117114417.GC1675@...30...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov 18 03:29:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Alberto Gonzalez Iniesta <agi@...64...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Wed, 17 Nov 2004, Alberto Gonzalez Iniesta wrote:

> Hi,
> 
> It seems [1] that specifying mssfix without a value, like the man page
> suggests [2], gives a fatal (Options) error now. Is this a new expected
> behaviour (that should be updated in the man page), or something not
> wanted?

It looks like since very early 2.0 releases, the ability to specify mssfix 
without a parameter, and then have it inherit the fragment parameter value 
was lost.

I know that 1.6 did this -- though with mssfix becoming the default in 
2.0, some of the finer details of the 1.6 semantics seems to have been 
lost.  I will try to fix this for beta18.

James


