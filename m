References: <1477650469-32431-1-git-send-email-janjust@...1147...>
	<67f3c1a0-8e94-b97e-2b9f-61ae81583c64@...1227...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <4464df62-454f-f525-4c08-b1448f4b2f5f@...1147...>
Date: Fri, 28 Oct 2016 13:44:18 +0200
MIME-Version: 1.0
In-Reply-To: <67f3c1a0-8e94-b97e-2b9f-61ae81583c64@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Allow "setenv opt" to be pushed from
 server to client
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi Arne,

On 28/10/16 13:08, Arne Schwabe wrote:
> Hm,
>
>
> I would like to see a rationale why this is needed. The client will
> already only warn on unsupported options. Your patch would make push
> "setenv opt unsupported" similar to "push unsupported".
the rationale behind this is based on an email thread on openvpn-users:

if I can set
   setenv opt UNSUPPORTED=1
in a client config, then why can't I push that from the server? it would allow an admin to do stuff like
   push "setenv opt register-dns"
which would apply only to the clients that support it (Windows) whereas no warnings are logged on other platforms. So it's more 
a way to suppress a warning message than anything else.  In theory you could also use "pull-filter" for this but that would 
require a change on all clients (and it won't work in 2.3 clients).

cheers,

JJK


