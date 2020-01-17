From: tincanteksup <tincanteksup@...277...>
References: <1d06b859-f531-5314-499a-11c70bb6363a@...515...>
 <52df2da3-eaf7-5364-510a-f7781d62ea9f@...515...>
 <917a22d3-dcca-15de-51e8-052c93bc2aed@...277...>
Message-ID: <8d5a9c20-156f-c369-ee5a-715fbb7029b9@...277...>
Date: Fri, 17 Jan 2020 12:39:00 +0000
MIME-Version: 1.0
In-Reply-To: <917a22d3-dcca-15de-51e8-052c93bc2aed@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Summary of the community meeting (16th January
 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Correction below.

On 17/01/2020 12:28, tincanteksup wrote:
> The following information is also applicable to *Nix.

> In order to use the upgrade, simply copy your EasyRSA-2 PKI (Generally 
> found in ./Keys directory under Easy-rsa directory) to Easyrsa3 
> directory and run:
> './easyrsa upgrade pki'

The upgrade also requires that 'vars' or 'vars.bat' be copied to the 
./easyrsa3 directory, in order to verify the CA is correct.


