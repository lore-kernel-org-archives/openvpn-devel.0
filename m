From: chantra <chantra@...1258...>
In-Reply-To: <4E0DBF8C.1050505@...544...>
References: <4E0DBF8C.1050505@...544...>
Content-Type: multipart/alternative; boundary="=-m7FKYLwJRdp/SnyxC9gt"
Date: Fri, 01 Jul 2011 18:52:00 +0200
Message-ID: <1309539120.2895.71.camel@...1471...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for HTTP Proxy with NTLM or error: NTLM
 Proxy-Authorization phase 3 failed: received corrupted data from proxy
 server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Pierre Crokaert <pct@...544...>
Cc: openvpn-devel@lists.sourceforge.net

--=-m7FKYLwJRdp/SnyxC9gt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-01 at 14:37 +0200, Pierre Crokaert wrote:

> Hello,
> 
> This kind of error occurs with some HTTP proxy. This happens when the 
> response from the server in phase 2 is longer than 128 bytes, in that 
> case the response is truncated because we are only interrested by the 
> beginning, but as it is still in base 64 format when it is truncated, it 
> must be truncated at a multiple of 4 chars. Today it truncated one char 
> too short and it results in a bad base64decode result and response is 
> rejected in phase 3.
> 
> This was reproduced and fixed on a Microsoft forefront proxy server.
> 
> Here is the patch against current git head (dc2ccc825c69...aacd)
> 
> @@ -519,7 +519,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
>   {
>     struct gc_arena gc = gc_new ();
>     char buf[512];
> -  char buf2[128];
> +  char buf2[129]; /* this buffer is a zero terminated base 64 string So it has to be a multiple of 4 char */
>     char get[80];
>     int status;
>     int nparms;
> @@ -642,7 +642,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
> 
>                 openvpn_snprintf (get, sizeof get, "%%*s NTLM %%%ds", (int) sizeof (buf2) - 1);
>                 nparms = sscanf (buf, get, buf2);
> -              buf2[127] = 0; /* we only need the beginning - ensure it's null terminated. */
> +              buf2[128] = 0; /* we only need the beginning - ensure it's null terminated.  and multiple of 4 char*/
> 
>                 /* check for "Proxy-Authenticate: NTLM TlRM..." */
>                 if (nparms == 1)
> 
> 

I dont know much about HTTP proxies, but:
- base64 is a multiple of 4
- code change is safe. There could have been an impact on buf2 at that
point [1] but buf2 being declared as "char buf2[128]" buffer overflow
should not happen

From me it would be an ACK :)

Just to make it easier to other people reveiving the patch, it is
happening in proxy.c

[1]
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn.git;a=blob;f=ntlm.c;h=4dfeed38909caa656b612dd1a553eb2ad35eaf9d;hb=HEAD#l245 



> 
> ------------------------------------------------------------------------------
> All of the data generated in your IT infrastructure is seriously valuable.
> Why? It contains a definitive record of application performance, security 
> threats, fraudulent activity, and more. Splunk takes this data and makes 
> sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-d2d-c2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 


-- 
http://www.debuntu.org

--=-m7FKYLwJRdp/SnyxC9gt
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.32.2">
</HEAD>
<BODY>
On Fri, 2011-07-01 at 14:37 +0200, Pierre Crokaert wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
Hello,

This kind of error occurs with some HTTP proxy. This happens when the 
response from the server in phase 2 is longer than 128 bytes, in that 
case the response is truncated because we are only interrested by the 
beginning, but as it is still in base 64 format when it is truncated, it 
must be truncated at a multiple of 4 chars. Today it truncated one char 
too short and it results in a bad base64decode result and response is 
rejected in phase 3.

This was reproduced and fixed on a Microsoft forefront proxy server.

Here is the patch against current git head (dc2ccc825c69...aacd)

@@ -519,7 +519,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
  {
    struct gc_arena gc = gc_new ();
    char buf[512];
-  char buf2[128];
+  char buf2[129]; /* this buffer is a zero terminated base 64 string So it has to be a multiple of 4 char */
    char get[80];
    int status;
    int nparms;
@@ -642,7 +642,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,

                openvpn_snprintf (get, sizeof get, &quot;%%*s NTLM %%%ds&quot;, (int) sizeof (buf2) - 1);
                nparms = sscanf (buf, get, buf2);
-              buf2[127] = 0; /* we only need the beginning - ensure it's null terminated. */
+              buf2[128] = 0; /* we only need the beginning - ensure it's null terminated.  and multiple of 4 char*/

                /* check for &quot;Proxy-Authenticate: NTLM TlRM...&quot; */
                if (nparms == 1)


</PRE>
</BLOCKQUOTE>
I dont know much about HTTP proxies, but:<BR>
- base64 is a multiple of 4<BR>
- code change is safe. There could have been an impact on buf2 at that point [1] but buf2 being declared as &quot;char buf2[128]&quot; buffer overflow should not happen<BR>
<BR>
From me it would be an ACK :)<BR>
<BR>
Just to make it easier to other people reveiving the patch, it is happening in proxy.c<BR>
<BR>
[1] <A HREF="http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn.git;a=blob;f=ntlm.c;h=4dfeed38909caa656b612dd1a553eb2ad35eaf9d;hb=HEAD#l245">http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn.git;a=blob;f=ntlm.c;h=4dfeed38909caa656b612dd1a553eb2ad35eaf9d;hb=HEAD#l245</A> <BR>
<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE>

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
<A HREF="http://p.sf.net/sfu/splunk-d2d-c2">http://p.sf.net/sfu/splunk-d2d-c2</A>
_______________________________________________
Openvpn-devel mailing list
<A HREF="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</A>
<A HREF="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</A>

</PRE>
</BLOCKQUOTE>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>
-- 
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A>
</PRE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-m7FKYLwJRdp/SnyxC9gt--



