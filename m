Message-ID: <20100120130832.19514.qmail@...1287...>
Date: Wed, 20 Jan 2010 14:08:32 +0100
From: Peter Stuge <peter@...1287...>
References: <4B56CBFD.7080900@...1294...>
MIME-Version: 1.0
In-Reply-To: <4B56CBFD.7080900@...1294...>
Subject: Re: [Openvpn-devel] Crosscompile OpenVPN 2.1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Eike Lohmann wrote:
> checking for lzo1x_1_15_compress in -llzo... no
> configure: error: LZO headers were found but LZO library was not found
..
> What exactly is missing and how to build it?

Look in config.log for the exact error from the configure test.
It would help to also post it here.


//Peter

