References: <201708291322.v7TDMcY3029206@...2300...>
 <20170829190353.GX70062@...1296...>
 <201708300839.v7U8dklY019715@...2300...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ed6292e5-2877-7ca8-bf7b-80fe8e7da72e@...1227...>
Date: Wed, 30 Aug 2017 23:39:57 +0200
MIME-Version: 1.0
In-Reply-To: <201708300839.v7U8dklY019715@...2300...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] Solaris 11: t_lpback.sh coredump on AES-GCM
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Casper.Dik@...2299..., "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 30.08.17 um 10:39 schrieb Casper.Dik@...2299...:
> 
> 
>>> After I figured out where we went wrong, I filed:
>>> 26336744 Solaris specific cleanup code breaks gcm_aes for, e.g., openvpn
>>> which has now been fixed in oracle solaris-userland on git hub
>>> https://github.com/oracle/solaris-userland/tree/master/components/openssl
>>
>> Cool, thanks a lot!
>>
>>> It cannot say exactly when it will be in Solaris 11.3 SRU (patch) release.
>>> Current workaround is disabling AES-GCM for openvpn but that should not be
>>> needed in the future.
>>
>> Is there a way to reliably detect this issue from a test program (or by
>> looking at system versions, like "uname")?  It might be worth adding a
>> configure test so users won't run into it ("AES-GCM disabled due to
>> bug 26336744 in Solaris OpenSSL").
> 
> Well, t_lpback would fail but that is late as then you would have 
> configured and compiled openvpn.
>

Does it fail reliable? If yes we could just run a quick version of
failing and if this fails disable AES support, especially disabling
cipher negoiation.

Arne

