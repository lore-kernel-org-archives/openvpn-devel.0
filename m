Message-ID: <40E53D6C.6070209@...231...>
From: sam <samwun@...231...>
MIME-Version: 1.0
References: <F8E527B8F1330C4789D452829B4F3EAC0924A7@...250...>
In-Reply-To: <F8E527B8F1330C4789D452829B4F3EAC0924A7@...250...>
Subject: [Openvpn-devel] Re: [Openvpn-users] Urgent: Limitation to 100  virtual tunnel dev
 ices??
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Jul  8 09:49:13 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Daniel Berger <db@...249...>
Cc: 'Claas Hilbrecht' <claas+maillinglists.openvpn@...232...>, Juerg.VonBueren@...245..., openvpn-devel@lists.sourceforge.net

Daniel Berger wrote:

>>I assume you need the following patch:
>>
>>diff -urN linux-2.4.26.org/net/core/dev.c linux-2.4.26/net/core/dev.c
>>--- linux-2.4.26.org/net/core/dev.c	Wed Apr 14 15:05:41 2004
>>+++ linux-2.4.26/net/core/dev.c	Thu Apr 15 18:54:01 2004
>>@@ -619,8 +619,12 @@
>>
>> 	/*
>> 	 * If you need over 100 please also fix the algorithm...
>>+	 *
>>+	 * Maybe it's never needed but just to be sure we allow
>>+	 * up to 1000 tun/tap devices.
>>+	 *
>> 	 */
>>-	for (i = 0; i < 100; i++) {
>>+	for (i = 0; i < 1000; i++) {
>> 		snprintf(buf,sizeof(buf),name,i);
>> 		if (__dev_get_by_name(buf) == NULL) {
>> 			strcpy(dev->name, buf);
>>
>>    
>>
>
>  
>
I just look at the code in FreeBSD, it handles 1000 tunnel by default:
case MOD_LOAD:

                /* intitialize device */   

                mtx_init(&tapmtx, "tapmtx", NULL, MTX_DEF);
                SLIST_INIT(&taphead);

                clone_setup(&tapclones);
                eh_tag = EVENTHANDLER_REGISTER(dev_clone, tapclone, 0, 
1000);
                if (eh_tag == NULL) {
                        clone_cleanup(&tapclones);
                        mtx_destroy(&tapmtx);
                        return (ENOMEM);
                }
                return (0);

Sit back and relax. :)
sam

>can this info be added to http://openvpn.sourceforge.net/install.html
>so that everyone knows it in the future?
>
>How is this with Kernel 2.6? 
>I checked the source of 2.6.7, but could'nt find this codefragment in
>/net/core/dev.c
>Anyone knows the limint in 2.6?
>
>Dani 
>
>  
>


