Message-ID: <519F5ED0.4070109@...1147...>
Date: Fri, 24 May 2013 14:36:32 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <519F04FA.5050303@...1823...>
	<20130524092300.GL20843@...1296...>
In-Reply-To: <20130524092300.GL20843@...1296...>
Subject: [Openvpn-devel] [PATCH] make "explicit-exit-notify" pullable again
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Dmitry Melekhov <dm@...1823...>

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d44f835..47df4cb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5084,8 +5084,7 @@ add_option (struct options *options,
 #ifdef ENABLE_OCC
   else if (streq (p[0], "explicit-exit-notify"))
     {
-      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-/*      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY); */
+      VERIFY_PERMISSION 
(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY);
       if (p[1])
        {
          options->ce.explicit_exit_notification = positive_atoi (p[1]);


share and enjoy,

JJK




Gert Doering wrote:
> Hi,
>
> On Fri, May 24, 2013 at 10:13:14AM +0400, Dmitry Melekhov wrote:
>   
>> Posted the same on forum :-)
>>     
>
> I'm not sure why that is *funny* - in general, I'd frown upon putting
> the same question in multiple places at the same time, as it causes
> extra work for other people who might not see both questions, so I might
> answer here and someone else might spend the time answering in the 
> forum.
>
>   
>> But today I installed update to 2.3.1 and I now I see:
>>
>> Options error: option 'explicit-exit-notify' cannot be used in this 
>> context ([PUSH-OPTIONS])
>>
>> Why? How can I revert to previous behavior?
>>     
>
> That is, indeed, a good question.  "git blame" points to...
>
> commit 76809cae0eae07817160b423d3f9551df1a1d68e
> Author: Jan Just Keijser <janjust@...1147...>
> Date:   Tue Feb 7 16:29:47 2012 +0100
>
>     Made some options connection-entry specific
>     Acked-by: David Sommerseth <davids@...1347...>
>
> ... which has lots of changes we thought we understand, plus:
>
> @@ -5106,14 +5108,15 @@ add_option (struct options *options,
>  #ifdef ENABLE_OCC
>    else if (streq (p[0], "explicit-exit-notify"))
>      {
> -      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
> +      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
> +//      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
>
>
> ... but since JJK is reading this list, he might have an answer, and a
> suggested fix for 2.3.2 :-)
>
> gert
>
>   



