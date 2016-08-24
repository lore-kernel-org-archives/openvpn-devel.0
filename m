Message-ID: <57BDA02C.4070502@...1147...>
Date: Wed, 24 Aug 2016 15:25:00 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
	<76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
	<3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
	<20160823123439.GA78279@...1296...>
	<57BD5780.2030204@...1147...>
	<f65edd44-e931-46e8-d21d-deda38005718@...515...>
	<57BD64D9.8010607@...1147...>
	<20160824125346.GK78279@...1296...>
In-Reply-To: <20160824125346.GK78279@...1296...>
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
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

On 24/08/16 14:53, Gert Doering wrote:
> On Wed, Aug 24, 2016 at 11:11:53AM +0200, Jan Just Keijser wrote:
>>>> just for my understanding: how would a user run an up/down script with
>>>> *USER* credentials (necessary to map a share or printer, for example) in
>>>> this scenario?
> [..]
>> Actually, how would a (clueless) user do this at all, using the
>> interactive service?  which part should be run with admin privs, which
>> part shouldn't ?    which credentials are available to the interactive
>> service (and any up/down scripts it may run) ?   should a user use a GUI
>> up/down script (I know the old GUI supported this) instead?
> If the iservice is around, it's all totally straightforward :-) - you
> run your --up script from the config.ovpn and it is run with your user
> credentials.
>
> Iservice works like this (we have a documentation page coming, but that's
> not there yet)
>
>   - the GUI runs as "me" (gert)
>   - the iservice runs as "local service", maximum privileges
>   - the GUI connects to the iservice, and asks it "run openvpn.exe with
>     the following arguments, using the credentials of the user the GUI runs
>     with" (windows can do this - pass credentials across a pipe, which you
>     can't fake)
>   - the iservice forks openvpn.exe, and runs this as user (gert), and
>     keeps a "service pipe" between iservice and openvpn.exe
>   - if openvpn.exe wants to do ifconfig/route/dns stuff, it sends these
>     as requests over the service pipe to the iservice, who will then
>     execute them (and clean up should openvpn crash)
>   - --up scripts are run by openvpn.exe itself, which is already running
>     as "gert", so, all privileges are nicely in place
>
> so this cannot be used anymore for privilege escalation to admin (by
> running an --up script from openvpn which is run-as-admin).
>
thanks for your explanation - all clear to me now. All we have to do now 
is to document this and add some tests to the buildbot ;)

JJK


