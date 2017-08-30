Message-Id: <201708300839.v7U8dklY019715@...2300...>
From: Casper.Dik@...2299...
In-Reply-To: <20170829190353.GX70062@...1296...> 
References: <201708291322.v7TDMcY3029206@...2300...>
 <20170829190353.GX70062@...1296...> 
Mime-Version: 1.0
Date: Wed, 30 Aug 2017 10:39:46 +0200
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net



>> After I figured out where we went wrong, I filed:
>> 26336744 Solaris specific cleanup code breaks gcm_aes for, e.g., openvpn
>> which has now been fixed in oracle solaris-userland on git hub
>> https://github.com/oracle/solaris-userland/tree/master/components/openssl
>
>Cool, thanks a lot!
>
>> It cannot say exactly when it will be in Solaris 11.3 SRU (patch) release.
>> Current workaround is disabling AES-GCM for openvpn but that should not be
>> needed in the future.
>
>Is there a way to reliably detect this issue from a test program (or by
>looking at system versions, like "uname")?  It might be worth adding a
>configure test so users won't run into it ("AES-GCM disabled due to
>bug 26336744 in Solaris OpenSSL").

Well, t_lpback would fail but that is late as then you would have 
configured and compiled openvpn.

This bug exists in Solaris 11.2 FCS.  Older versions, as you have seen, do 
not have GCM support so you would not find the bug.

The best way to find the install Solaris version in Solaris 11 and later 
is "pkg list entire"; this will print:

NAME (PUBLISHER)                                  VERSION                    IFO
entire                                            0.5.11-0.175.3.22.0.3.0    i--

The actual string is pretty much an "historical accident" but the 
important bits are: 0.5.11-0.175.*3*.*22*.0.3.0

The first three is the minor version (11.*3*) and the *22* is the 
installed SRU.

For now, I think for Solaris 11+ we should disable gcm which I currently 
do by hand by changing

	#define HAVE_AEAD_CIPHER_MODES 1 
to
	#undef HAVE_AEAD_CIPHER_MODES

Casper

	


