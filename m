Message-ID: <20100828045408.17377.qmail@...1287...>
Date: Sat, 28 Aug 2010 06:54:08 +0200
From: Peter Stuge <peter@...1287...>
References: <4C77640D.6000708@...515...> <20100828024617.942.qmail@...1287...>
	<AANLkTinftXxDOX4J=njhby1oEKRtZUZGb57EgPdMiGsz@...278...>
MIME-Version: 1.0
In-Reply-To: <AANLkTinftXxDOX4J=njhby1oEKRtZUZGb57EgPdMiGsz@...278...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (26th Aug 2010)
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

Alon Bar-Lev wrote:
> > > Did some testing to see if creating a static binary would be
> > > trivial. As it was not,
> >
> > Why wasn't it? Please share details from the testing.
> 
> I guess the modules, pkcs11 and other components that uses dlopen
> should be disabled in openvpn.

Well, as a first step it would be nice to build the openvpn binary
statically. Even if it still uses dlopen e.g. for p11.


//Peter

