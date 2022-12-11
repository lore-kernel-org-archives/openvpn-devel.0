Message-ID: <fa659222-2b20-82d5-36d9-9f320592b1e4@...2704...>
Date: Sun, 11 Dec 2022 21:15:16 +0100
MIME-Version: 1.0
References: <1386e3cc-fc65-aa68-fa88-3639f6aec5a2@...2704...>
 <20221211192124.1126-1-marc.becker@...2704...>
 <CAKuzo_iFLmH3R=K6LKcbii+vzyCvU8c6hxKRCtHuRd8gt75z0A@...278...>
Content-Language: de-DE, en-US
From: Marc Becker <marc.becker@...2704...>
In-Reply-To: <CAKuzo_iFLmH3R=K6LKcbii+vzyCvU8c6hxKRCtHuRd8gt75z0A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/3] special handling for PKCS11
 providers on win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

my suggestion would be to decide if we want v2 or v3 of 3/3
depending on the pkcs11-helper state immediately before next beta.

OpenVPN 2.6 changing behavior shortly after release would be something
to avoid in any case.
Having the patch around in 2.6 branch only and dropping it in 2.6.1 may 
also be an acceptable compromise:
3/3 v2 -> 2.6 branch
3/3 v3 -> master

The timeline for pkcs11-helper releases is not something I even dare to 
predict. :)


Regrads,
Marc

