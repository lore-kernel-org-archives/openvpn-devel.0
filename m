References: <CAFHpkQEbh-5aOm-R7HPUBYq2TcFXYQ=XNd8rAo3955LVFjaK9Q@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <170309cd-7640-286c-a7b6-5ff82acc0bbc@...1227...>
Date: Wed, 13 Jan 2021 20:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEbh-5aOm-R7HPUBYq2TcFXYQ=XNd8rAo3955LVFjaK9Q@...278...>
Subject: Re: [Openvpn-devel] is it possible to store saved password in tpm
 instead of registry ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>


Am 13.01.2021 um 17:20 schrieb Илья Шипицин:
> Hello,
>
> if user save password, it might be stolen from well known location 
> (there are popular password stealers).
>
> in theory, is it possible to keep password in tpm ? will it prevent 
> password from being stolen ?
>
> Ilya

Password storage in TPM is flawed anyway. Since it a symmetric secret. 
If you want TPM security you should go certificate anyway which should 
be doable by using a TPM as a smart card.

Arne


