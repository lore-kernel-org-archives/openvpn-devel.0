References: <20210922211254.7570-1-selva.nair@...277...>
 <ed918ec7-2301-0e66-4bbe-f9141c97b406@...1227...>
 <CAKuzo_iC46yGz+hjyZvmxyh=PeNw_UPMMyxKEXm6Yxb0dSao5w@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <10f4cf44-bd1d-7ff2-2bb4-69e94d796576@...1227...>
Date: Thu, 23 Sep 2021 17:27:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iC46yGz+hjyZvmxyh=PeNw_UPMMyxKEXm6Yxb0dSao5w@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 23.09.21 um 16:02 schrieb Selva Nair:
> 
> Hi Arne,
> 
> 
>     So I have two options here:
> 
>     a) I finish my own implementation of the provider for OpenVPN3 to not be
>     influenced by this implementation and review this implementation
>     after that
> 
>     b) you agree that I can take parts of your code for the OpenVPN3
>     implementation, then I go directly into review and then base my OpenVPN3
>     implementation on your xkey provider implementation.
> 
> 
> (b) is fine with me and preferred. I do not want to release it under
> BSD, but can agree to  a CLA. I wrote it consulting OpenSSL sources
> (though no copy paste) which is not GPL2, so not even sure what license
> is most appropriate. But BSD isi not my thing. 

I think a statement from you that you agree to
https://github.com/OpenVPN/openvpn3/blob/master/CLA.rst
for this patchset would be good and I think also enough.

Arne

