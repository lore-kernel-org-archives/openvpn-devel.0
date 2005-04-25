From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
Message-ID: <20050425104620.V15659@...283...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...><20050420091539.C21 <20050420091539.C21450@...283...> <Pine.LNX.4.58.0504201125560.14131@...41...><20050420141742.B1503@...381... <20050420141742.B1503@...283...> <Pine.LNX.4.58.0504211811260.14131@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0504211811260.14131@...41...>; from jim@...41... on Thu, Apr 21, 2005 at 06:27:03PM -0600
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
Date: Mon Apr 25 07:45:09 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: JuanJo Ciarlante <jjo-ipsec@...283...>, openvpn-devel@lists.sourceforge.net

On Thu, Apr 21, 2005 at 06:27:03PM -0600, James Yonan wrote:
> I would like to merge your IPv6 patch into the 2.1 branch, once it gets 
> started (I'd like to keep the 2.0.x branch as stable as possible, with 
> minimalistic changes that don't go beyond bug fixes and small patches).
> 
> One potential speed bump will be in merging both IPv6 + the multihomed 
> patch which will definitely be going into 2.1:
> 
> http://openvpn.net/patch/openvpn-2.0_rc16MH.patch
> 
> Because both patches touch much of the same code, there will likely be a
> need for manual merging.

Ok ... indeed I tested "patch --dry ..." and shouted about 80% rejects.
I could merge both in my own CVS, but because it's a rather daunting task, 
I would like to be sure it's a productive one :-) ie. that it will have a
high chance to be merged , of course, if resulting patch quality qualifies.

Regards...

-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

