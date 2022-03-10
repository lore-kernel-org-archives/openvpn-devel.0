Message-ID: <55350ddb-4cc6-184b-7305-4866ab20df56@...2663...>
Date: Thu, 10 Mar 2022 17:51:36 +0100
MIME-Version: 1.0
Content-Language: de-DE
References: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...>
 <45ef346e-868c-b5de-5937-6ae9fc0d578f@...1227...>
From: Jakob Curdes <jc@...2663...>
In-Reply-To: <45ef346e-868c-b5de-5937-6ae9fc0d578f@...1227...>
Subject: Re: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello list, hello Arne,

Am 10.03.2022 um 16:32 schrieb Arne Schwabe:
> Am 10.03.22 um 15:14 schrieb Jakob Curdes:
>> Thu Mar 10 10:35:32 2022 AUTH: Received control message: 
>> AUTH_FAILED,CRV1:R,E:1796:Yoirtuqeprtiqrew4==:*Type "p" to receive a 
>> push notification or type your one-time password*
>>
>> /(Typed in "p")
>> /
>> Thu Mar 10 10:35:32 2022 SIGUSR1[soft,auth-failure] received, process 
>
> Where are you typing this in? in the normal cmd.exe terminal that runs 
> OpenVPN? because that looks like the client just gives you the 
> AUTH_FAILED and then proceeds to connect to the next server.

In a "graphical" popup window of the Windows OpenVPN client which 
appears when the server is configured to do 2FA. The popup window 
displays the text from the above log message "ype "p" to receive a push 
notification or type your one-time password". THe first auth-failed 
seems to be normal, after that the popup is displayed and when all is 
well the auth succeeds in the second round.


>
>> restarting
>> Thu Mar 10 10:35:32 2022 MANAGEMENT: 
>>  >STATE:1646904932,RECONNECTING,auth-failure,,,,,
>> Thu Mar 10 10:35:32 2022 Restart pause, 5 second(s)
>> *Thu Mar 10 10:35:40 2022 Previous command sent to management failed: 
>> ERROR: Options warning: Bad backslash ('\') usage in TCP:0: remember 
>> that backslashes are treated as shell-escapes and if you need to pass 
>> backslash characters as part of a Windows filename, you sho*
>> Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'username "Auth" 
>> "*authpoint\UserN*"'
>> Thu Mar 10 10:35:40 2022 MANAGEMENT: CMD 'password [...]'
>>
>> This sounds like I need to escape the backslash, but if I do this the 
>> auth fails completely before the 2FA part comes into the picture.
>> Other tricks like forward slashes or "@" do not help here as these 
>> are not understood by the auth backend in the firebox.
>> When using the WatchGuard SSL VPN app this all works (and it has 
>> OpenVPN inside....) but I would like to stick to the OpenVPN clients 
>> as all the users already have it and know how to handle it.
>>
>> Best regards and thank you for hints,
>
> The new auth-pending method is much easier to implement. With the old 
> method you need to part the AUTH_FAILED message and wait until the 
> client asks again for the user password on the next connection and 
> give the session password/repsonse then.
>
> For the new method, example of implmentating it on Android:
>
The problem is that I have no control over the method that is used, as I 
cannot freely configure the embedded OpenVPN server in the Firebox.
I think it is just a string handling bug somewhere. On the user list, 
this morning there was a hint to

"I suspect that in manage.c the "parse_line" call does not differentiate 
between file paths (for which \\ is needed) and a "domain\username" call."
which seems to refer to manage.c in the openvpn repository. Does that 
make sense? I looked at the code but my C programming knowledge is limited.

JC



