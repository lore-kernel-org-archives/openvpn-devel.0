Message-ID: <e641efbb-293f-b696-702c-2ccfac58afe7@...2181...>
Date: Sat, 8 Jan 2022 11:17:16 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <001901d80463$e5c4e830$b14eb890$@chinatelecom.cn>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <001901d80463$e5c4e830$b14eb890$@chinatelecom.cn>
Subject: Re: [Openvpn-devel] ovpn-dco
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
To: yuanxun <yuanx3@...2645...>, openvpn-devel@lists.sourceforge.net

Hi,

Thanks a lot for testing!

On 08/01/2022 08:46, yuanxun wrote:
> HI!
> 
> I am using openvpn and want to test the real data of ovpn-dco in my 
> environment..
> 
> I m having some trouble and don t understand the kernel so seek your help.
> 
> My environment is a centos, 5.4.168-1.el7.elrepo.x86_64. Not sure if 
> anyone has installed successfully in centos.
> 
> And the openvpn process is started successfully, and the main problem is 
> from libnl.
> 
> Libnl version:
> 
> Openvpn.log:
> 
> Under what circumstances is this error displayed and what should I do

Gert, replied to your private email already, and, as he said, you 
probably are dropping privileges to a non-root user.

While this is possible, you need to make sure that openvpn still retains 
CAP_NET_ADMIN, so that it can happily send netlink messages.

The easy solution (At least for testing) would be to not drop privileges 
(i.e. remove --user from your config).

Regards,

-- 
Antonio Quartulli

