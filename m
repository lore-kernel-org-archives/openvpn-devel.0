Message-ID: <ffffcce0-1c0b-cd4e-95c5-b17d523cbf30@...2108...>
Date: Tue, 1 Aug 2023 20:22:24 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAEeEfvzkhp_FQ8cnOZcASiVbDN8=+Gw_2sV5SNonL5x7OYb1jA@...278...>
 <892bc3fa-b752-b959-1ea4-19b106c0915c@...1227...>
 <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAEeEfvyw2AKiKV1DW2mPA8C332pK7nroA9=BtpqEND2TPGmFog@...278...>
Subject: Re: [Openvpn-devel] [PATCH OpenVPN3] Add 'pull' to ignored options
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
To: Merten Fermont <merten.fermont@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 27/07/2023 14:21, Merten Fermont wrote:
> Hi Arne,
> 
> I changed my patch to check the client and client+pull options.
> Giving an error when neither options are declared.
> 
> This however may break current implementations that depend on 'client'
> not being a required option?
> 
> Greetings,
> Merten
> 
> Subject: [PATCH] Check for client options
> 

Hi,

Thanks for your patch.  Changes looks reasonable to me as well, and I 
wanted to pull it in.  But it turns out that the patch has been mangled 
somehow.  Even good old 'patch' refuses to apply anything.  This is not 
an unknown issue with gmail.com; which is why we generally recommend to 
use 'git send-mail' [1].

In this specific case, resending the patch as an attachment can also work.


[1] <https://git-scm.com/docs/git-send-email>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


