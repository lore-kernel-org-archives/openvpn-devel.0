References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <57A72DA2.1090003@...277...>
Date: Sun, 7 Aug 2016 13:46:26 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 05/08/16 03:04, Selva Nair wrote:
> On Thu, Aug 4, 2016 at 6:53 PM, debbie10t <debbie10t@...277...> wrote:
>
>> Hi
>>
>> So windows 10 as a Server.
>>
>>
>> If you have any specific tests please send me details.
>>
> Tasks needing admin access happens early on when the server starts so this
> looks good especially since you tested ipv6 as well.
>
> One thing to try:
> With the server running, edit the config to change the tunnel network (ip
> and pool) and issue a SIGHUP to re-read the config (reconnect from the GUI
> status window will do this). The old routes should get torn down (log will
> show route deletion via service succeeded) the ip should change to the new
> one and new routes get added etc.
This worked no problem.

>
> Although not related to the interactive service, you could also test
> running the server on a port < 1024. This being windows I suppose binding
> to "privileged" ports doesn't require admin rights.
>
>
Have not tried this yet.


However, during my testing the following happened:

I installed the first server in /program files/openvpn/config and running
as standard-user with openvpn GUI & IService, this worked no problem.

Then I tried with the config file in /users/user/openvpn/config and running
as standard-user:user with gui & IService, Starting the server, I was 
prompted
to add my user to the openvpn administrators group.

I am not sure if this is intended behaviour, that the group membership is
*only* prompted when using user/openvpn/config/file.ovpn ?

-- 


