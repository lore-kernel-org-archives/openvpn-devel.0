References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
Date: Sun, 11 Dec 2016 14:06:49 +0000
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
Subject: Re: [Openvpn-devel] On saving passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 09/12/16 17:38, Selva Nair wrote:
> Hi,
>
> A comment  on the GUI github page said:
>
> "For ISO27001 certification, we are not allowed to let users save their VPN
> passwords locally. Is there a way to remove or disable the 'save password'
> box upon authentication ?"
>
> Although I suggested to use an up script to delete the saved password, the
> GUI displaying a checkbox to save password may not be acceptable to some
> setups. Any idea how widespread a concern is this? Note that the GUI saves
> it encrypted. Personally I believe not saving passwords encourages users to
> choose weak passwords, but we could make the GUI respect any --auth-nocache
> in the config.
>
> More info here (https://github.com/OpenVPN/openvpn-gui/issues/105)
>
> Thanks,
>
> Selva
>

my2c

I think it is down to individual server admins to make this call ..
If they have a policy which demands that passwords not be saved and
openvpn does not have a robust method to do so, what will they do ?

Is it possible to have --push "auth-nocache-override" which enables
client --auth-nocache and cannot be filtered out ?

Regards

