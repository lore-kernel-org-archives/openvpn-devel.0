Message-Id: <201708291322.v7TDMcY3029206@...2300...>
From: Casper.Dik@...2299...
Mime-Version: 1.0
Date: Tue, 29 Aug 2017 15:22:38 +0200
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


I recently run into the same problem as Jens Neuhalfen has reported
more than a year ago in this mailing list.

As I was somewhat confused why the shipped Solaris openssl version failed, 
I looked into that issue as I also wanted to run a recent 
openvpn on Solaris 11.x.

After I figured out where we went wrong, I filed:

26336744 Solaris specific cleanup code breaks gcm_aes for, e.g., openvpn

which has now been fixed in oracle solaris-userland on git hub

https://github.com/oracle/solaris-userland/tree/master/components/openssl

It cannot say exactly when it will be in Solaris 11.3 SRU (patch) release.

Current workaround is disabling AES-GCM for openvpn but that should not be 
needed in the future.

Casper


