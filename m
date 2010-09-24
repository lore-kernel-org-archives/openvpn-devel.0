Message-ID: <4C9C5002.4070806@...1147...>
Date: Fri, 24 Sep 2010 09:15:14 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>	<4C8E9E7B.9020308@...1299...>	<20100914074032.GA10703@...1296...>	<4C8F3C04.8020904@...1147...>
	<20100914113722.GB10703@...1296...>
	<4C8F79BC.7090602@...1114...>
In-Reply-To: <4C8F79BC.7090602@...1114...>
Subject: Re: [Openvpn-devel] Enhancements.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

Yo all,

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 14/09/10 13:37, Gert Doering wrote:
>   
>> Hi,
>>
>> On Tue, Sep 14, 2010 at 11:10:28AM +0200, Jan Just Keijser wrote:
>>     
>>>>          if (buf_string_match_head_str (&buf, "AUTH_FAILED"))
>>>>            receive_auth_failed (c, &buf);
>>>>          else if (buf_string_match_head_str (&buf, "PUSH_"))
>>>>            incoming_push_message (c, &buf);
>>>>          else if (buf_string_match_head_str (&buf, "RESTART"))
>>>>            server_pushed_restart (c, &buf);
>>>>          else
>>>>            msg (D_PUSH_ERRORS, "WARNING: Received unknown control 
>>>>            message: %s",
>>>> BSTR (&buf));
>>>>         
>>> is the control message stage early enough? that means authentication has 
>>> been completed, and the client_connect script has been run (or am I 
>>> mistaken? 
>>>       
>> I'm not absolutely sure at what time these messages can be sent.  But
>> most likely you're right, you want this before running client-connect.
>>
>> Someone around who fully understands the session flow...?
>>
>>     
>
> Taken completely from memory, the PUSH_REQ phase comes in _after_ the
> authentication process.  But, I also believe it comes after
> OPENVPN_PLUGIN_CLIENT_CONNECT phase, as that plug-in hook can push
> config settings to the client dynamically.  And of the
> OPENVPN_PLUGIN_CLIENT_CONNECT hook sends a rejection, the connection is
> dropped.
>
> Unless somebody else chimes in before I've been able to double check it,
> I'll do some more checks here.
>
>
>   
I was just browsing through the 2.1.3 source tree and found this in ssl.c:

3379 static bool
3380 push_peer_info(struct buffer *buf, struct tls_session *session)
3381 {
3382   struct gc_arena gc = gc_new ();
3383   bool ret = false;
3384
3385 #ifdef ENABLE_PUSH_PEER_INFO
3386   if (session->opt->push_peer_info) /* write peer info */
3387     {
3388       struct env_set *es = session->opt->es;
3389       struct env_item *e;
3390       struct buffer out = alloc_buf_gc (512*3, &gc);
3391
3392       /* push version */
3393       buf_printf (&out, "IV_VER=%s\n", PACKAGE_VERSION);
3394
3395       /* push platform */
3396 #if defined(TARGET_LINUX)
3397       buf_printf (&out, "IV_PLAT=linux\n");
3398 #elif defined(TARGET_SOLARIS)


this gets called if --push-peer-info is specified . This seems to be new 
for 2.1.3 - has anyone tested it?

cheers,

JJK


