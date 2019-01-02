From: tincanteksup <tincanteksup@...277...>
References: <99D61A626FDA8A4B90A270669121BE109BE8AA4C@...2294...>
 <76addf9c-a14e-0e59-bb01-dace07b56a03@...277...>
 <775f6ca7-227f-6ae9-2206-1fa3d11b6376@...277...>
 <5aa26403-9948-df7a-6eaa-a6c1d0ba0a29@...277...>
 <99D61A626FDA8A4B90A270669121BE109BE8D349@...2294...>
 <CC83ED38-544A-4750-8AD0-6E5B60141864@...2293...>
 <a9509aa8-559c-9abc-db30-b3588bb2b6e1@...277...>
Message-ID: <b3c46f54-fc61-80c8-a8c8-328e2bb1f9af@...277...>
Date: Wed, 2 Jan 2019 15:16:57 +0000
MIME-Version: 1.0
In-Reply-To: <a9509aa8-559c-9abc-db30-b3588bb2b6e1@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [Help required] Testing MSI installations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Simon Rozman <simon@...2293...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 02/01/2019 14:11, tincanteksup wrote:
> Successfully install 32bit from .exe
> 

However, there appears to be a problem ..

https://paste.fedoraproject.org/paste/Ih2LYl0cR8YoKnI2lNwhcQ

Part 1 is the client log *with* errors using the binary from your
installer 2.4.6-m4 dated 1/Jan/2019

Part 2 is the routing before and after part 1

Part 3 is the client log *without* errors using the binary from
the official installer 2.4.6 dated 26/Apr/2018

Both logs are for the same config file on the same machine
Windows 7 32bit VM -- Fully upto date with MS.

Even though there are errors reported the VPN still works for both
IPv4 and 6 with both versions of the binary.


