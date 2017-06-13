References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
	<CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
Date: Tue, 13 Jun 2017 15:26:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Selva, thanks for your answer.

On 12/06/17 20:23, Selva Nair wrote:
> On Wed, Jun 7, 2017 at 12:41 PM, debbie10t <debbie10t@...277...> wrote:
> 
>> Hi,
>>
>> I have a basic setup and discovered that my W10 client was assigning a
>> second IPv6 address to TAP even though it is *not* being pushed by the
>> server.  The second address is an old address from a server that I
>> sometimes connect to.  The server is still running but the client is not
>> connected to it.
>>
>> The most significant information here is that this *only* happens when
>> using the openvpn-GUI + interactive-service.

> The service should delete the address when openvpn terminates so can't
> think of any reason why an old address would linger even if the same tap
> adapter was used for the previous connection.

I decided to try some tests .. in fact I only did one test.
I rebooted the PC and now the second IP address has gone.
(Windows Fast shutdown/reboot disabled .. so full reboot)

I also tried to recreate the problem but so far cannot ..
No changes have been made to my configs or host W10 pc ..
but I did realise that both configs in question *do* use the same TAP 
adapter .. connecting to each server in turn repeatedly did not recreate 
the problem .. and even doing crazy things one might do while under the 
influence did not recreate the problem.  Even terminating via task 
manager could not recreate the problem ..

Chalk this one down to windows weirdness .. Just have to watch out if it 
ever happens again.

> Does this happen only on Win 10?

Only one time I have seen it and now can't recreate it.

> Wed Jun 07 16:33:53 2017 us=125353 ROUTE: route addition failed using
>> service: The object already exists.   [status=5010 if_index=17]
> 
> 
> This is a known issue (route not deleted on termination so fails to
> recreate later) and is not a critical. FWIW, there is a patch on the ML to
> fix it.

I'll keep an eye open for this.

Thanks



