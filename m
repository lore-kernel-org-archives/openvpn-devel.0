References: <CAFHpkQEbh-5aOm-R7HPUBYq2TcFXYQ=XNd8rAo3955LVFjaK9Q@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <3437a0a5-6522-9f29-4e98-b3b90f490f4d@...1147...>
Date: Wed, 13 Jan 2021 18:01:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEbh-5aOm-R7HPUBYq2TcFXYQ=XNd8rAo3955LVFjaK9Q@...278...>
Content-Language: en-US
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

Hi,

On 13/01/21 17:20, Илья Шипицин wrote:
> Hello,
>
> if user save password, it might be stolen from well known location 
> (there are popular password stealers).
>
> in theory, is it possible to keep password in tpm ? will it prevent 
> password from being stolen ?
>
in theory, yes, but as always, it depends on the circumstances.

With TPM 1.2 you can only store a very limited amount of data in the TPM 
chip; the (open source) implementation I have seen (tss, trousers) store 
a key in the TPM to scramble other data with; thus, you can encrypt a 
private key or password with a key stored on the TPM and only if you 
have the TPM will you be able to decrypt it.
I've never been particularly impressed with the security of this setup, 
however, as trousers seems to suggest to store the actualy decryption 
key in an environment variable...

With TPM 2.0 you can store more data in the chip, including a full 
private key. This makes it behave more like a regular PKCS#11 device, 
where you store the private key, not the user password on it. Of course, 
it will/should also be possible to store a user password on it.

cheers,

JJK


