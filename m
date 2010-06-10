From: chantra <chantra@...1258...>
In-Reply-To: <1275862374.2183.61.camel@...1259...>
References: <1275862374.2183.61.camel@...1259...>
Content-Type: multipart/mixed; boundary="=-vqnDWnzTHZyIsmDt2XvH"
Date: Thu, 10 Jun 2010 22:57:41 +0200
Message-ID: <1276203461.2615.46.camel@...1259...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Enabling Accounting/Stats for plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--=-vqnDWnzTHZyIsmDt2XvH
Content-Type: multipart/alternative; boundary="=-17fb5Nzq1kpzHx/eoJMe"

--=-17fb5Nzq1kpzHx/eoJMe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


As agreed at today's IRC meeting, I created a test plugin showing the
usage of a new plugin hook called 
OPENVPN_PLUGIN_ACCOUNTING

Please see https://community.openvpn.net/openvpn/ticket/15 for the
plugin code.

As agreed on IRC, I cooked up a demo implementation of this new plugin
hook.
Below is an except of the comment I added to the track ticket:

Tks,


Basically the idea is to be able to implement AAA
(http://en.wikipedia.org/wiki/AAA_protocol) (through radius for
instance) with an openvpn plugin.


The benefit is that it is then possible to get network usage per client
from within a plugin without starting a new process that will handle
that in the background by parsing regurlarly openvpn-status.log or
initiating a connection to the management console.


The plugin is taking advantage of the return_list parameter available in
openvpn_plugin_func_v2 to update the interval at which is wants to
receive update for a specific client.
A default value of 60 second is hardcoded within the options, but it can
be changed at startup through --accounting-freq n command switch


A value of 0 will disable accounting information to be sent.


For compiling instructions and how to run the testing environmen, please
check the comments in testplugin.c 


The scenario would be as follow:



     1. plugin in invoke with type OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
        plugin sends credentials to authentication server and returns
        success/error to main loop 
     2. on success, plugin is called with
        OPENVPN_PLUGIN_CLIENT_CONNECT_V2 
              * plugin send a message to accounting server informing it
                that the session starts 
              * plugin receive an update interval value (let call it
                acct_interval) at which it should send updated
                information to accounting server. this acct_interval is
                passed to accounting server through return_list 
     3. time passes, traffic goes through 
     4. when acct_interval time is passed, the plugin is invoked with
        OPENVPN_PLUGIN_ACCOUNTING. bytes_sent/bytes_received being
        passed through envp 
              * plugin contact accounting server and give it those
                value 
              * accounting server might reply with a new acct_interval
                that plugin can pass back to openvpn server through
                return_list 
     5. 3) and 4) repeat 
     6. Client is disconnected, openvpn main loop will invoke plugin
        with OPENVPN_PLUGIN_CLIENT_DISCONNECT, plugin informs accounting
        server that session is stopped and that
        bytes_sent/bytes_received was used over time_duration


Here is the output of a session realised with the attached test plugin,.
Mind that after 1minute or so i disconnected the client, hence no packet
were going through so the eventtimeout was not triggered at the exact
second. In a normal scenario, update would not happen every so often,
here low random values were given to illustrate the usage.


Any things that are unclear, le me know.
Tks



Thu Jun 10 16:19:30 2010 192.168.51.1:40289 [ssss] Peer Connection Initiated with 192.168.51.1:40289
ACCT Thu Jun 10 16:19:30 2010
 Sending start time to accounting server 1276179570
ACCT Thu Jun 10 16:19:30 2010
 Plugin requested accounting update in 11 seconds
--
Thu Jun 10 16:19:41 2010 DEBUG: ACCOUNTING triggerred after 11s for ssss
ACCT Thu Jun 10 16:19:41 2010
 Sending accounting information to server 5724tx/3663rx
ACCT Thu Jun 10 16:19:41 2010
 Acounting server requesting new update in 5 seconds
--
Thu Jun 10 16:19:46 2010 DEBUG: ACCOUNTING triggerred after 5s for ssss
ACCT Thu Jun 10 16:19:46 2010
 Sending accounting information to server 6349tx/4288rx
ACCT Thu Jun 10 16:19:46 2010
 Acounting server requesting new update in 9 seconds
--
Thu Jun 10 16:19:55 2010 DEBUG: ACCOUNTING triggerred after 9s for ssss
ACCT Thu Jun 10 16:19:55 2010
 Sending accounting information to server 7474tx/5413rx
ACCT Thu Jun 10 16:19:55 2010
 Acounting server requesting new update in 19 seconds
--
Thu Jun 10 16:20:14 2010 DEBUG: ACCOUNTING triggerred after 19s for ssss
ACCT Thu Jun 10 16:20:14 2010
 Sending accounting information to server 9849tx/7788rx
ACCT Thu Jun 10 16:20:14 2010
 Acounting server requesting new update in 16 seconds

-- 
http://www.debuntu.org



!DSPAM:4c1151c761671553511658!

--=-17fb5Nzq1kpzHx/eoJMe
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
<BR>
As agreed at today's IRC meeting, I created a test plugin showing the usage of a new plugin hook called <BR>
OPENVPN_PLUGIN_ACCOUNTING<BR>
<BR>
Please see <A HREF="https://community.openvpn.net/openvpn/ticket/15">https://community.openvpn.net/openvpn/ticket/15</A> for the plugin code.<BR>
<BR>
As agreed on IRC, I cooked up a demo implementation of this new plugin hook.<BR>
Below is an except of the comment I added to the track ticket:<BR>
<BR>
Tks,<BR>
<BR>
<BR>
Basically the idea is to be able to implement <A HREF="http://en.wikipedia.org/wiki/AAA_protocol">AAA</A> (http://en.wikipedia.org/wiki/AAA_protocol) (through radius for instance) with an openvpn plugin.<BR>
<BR>
<BR>
The benefit is that it is then possible to get network usage per client from within a plugin without starting a new process that will handle that in the background by parsing regurlarly openvpn-status.log or initiating a connection to the management console.<BR>
<BR>
<BR>
The plugin is taking advantage of the return_list parameter available in openvpn_plugin_func_v2 to update the interval at which is wants to receive update for a specific client.<BR>
A default value of 60 second is hardcoded within the options, but it can be changed at startup through --accounting-freq n command switch<BR>
<BR>
<BR>
A value of 0 will disable accounting information to be sent.<BR>
<BR>
<BR>
For compiling instructions and how to run the testing environmen, please check the comments in testplugin.c <BR>
<BR>
<BR>
The scenario would be as follow:<BR>
<BR>
<BR>
<OL TYPE=1>
    <LI TYPE=1 VALUE=1>plugin in invoke with type OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY plugin sends credentials to authentication server and returns success/error to main loop 
    <LI TYPE=1 VALUE=2>on success, plugin is called with OPENVPN_PLUGIN_CLIENT_CONNECT_V2 
    <UL>
        <LI>plugin send a message to accounting server informing it that the session starts 
        <LI>plugin receive an update interval value (let call it acct_interval) at which it should send updated information to accounting server. this acct_interval is passed to accounting server through return_list 
    </UL>
    <LI TYPE=1 VALUE=3>time passes, traffic goes through 
    <LI TYPE=1 VALUE=4>when acct_interval time is passed, the plugin is invoked with OPENVPN_PLUGIN_ACCOUNTING. bytes_sent/bytes_received being passed through envp 
    <UL>
        <LI>plugin contact accounting server and give it those value 
        <LI>accounting server might reply with a new acct_interval that plugin can pass back to openvpn server through return_list 
    </UL>
    <LI TYPE=1 VALUE=5>3) and 4) repeat 
    <LI TYPE=1 VALUE=6>Client is disconnected, openvpn main loop will invoke plugin with OPENVPN_PLUGIN_CLIENT_DISCONNECT, plugin informs accounting server that session is stopped and that bytes_sent/bytes_received was used over time_duration
</OL>
<BR>
Here is the output of a session realised with the attached test plugin,.<BR>
Mind that after 1minute or so i disconnected the client, hence no packet were going through so the eventtimeout was not triggered at the exact second. In a normal scenario, update would not happen every so often, here low random values were given to illustrate the usage.<BR>
<BR>
<BR>
Any things that are unclear, le me know.<BR>
Tks<BR>
<BR>
<BR>
<PRE>
Thu Jun 10 16:19:30 2010 192.168.51.1:40289 [ssss] Peer Connection Initiated with 192.168.51.1:40289
ACCT Thu Jun 10 16:19:30 2010
 Sending start time to accounting server 1276179570
ACCT Thu Jun 10 16:19:30 2010
 Plugin requested accounting update in 11 seconds
--
Thu Jun 10 16:19:41 2010 DEBUG: ACCOUNTING triggerred after 11s for ssss
ACCT Thu Jun 10 16:19:41 2010
 Sending accounting information to server 5724tx/3663rx
ACCT Thu Jun 10 16:19:41 2010
 Acounting server requesting new update in 5 seconds
--
Thu Jun 10 16:19:46 2010 DEBUG: ACCOUNTING triggerred after 5s for ssss
ACCT Thu Jun 10 16:19:46 2010
 Sending accounting information to server 6349tx/4288rx
ACCT Thu Jun 10 16:19:46 2010
 Acounting server requesting new update in 9 seconds
--
Thu Jun 10 16:19:55 2010 DEBUG: ACCOUNTING triggerred after 9s for ssss
ACCT Thu Jun 10 16:19:55 2010
 Sending accounting information to server 7474tx/5413rx
ACCT Thu Jun 10 16:19:55 2010
 Acounting server requesting new update in 19 seconds
--
Thu Jun 10 16:20:14 2010 DEBUG: ACCOUNTING triggerred after 19s for ssss
ACCT Thu Jun 10 16:20:14 2010
 Sending accounting information to server 9849tx/7788rx
ACCT Thu Jun 10 16:20:14 2010
 Acounting server requesting new update in 16 seconds
</PRE>
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
<BR>

!DSPAM:4c1151c761671553511658!

</BODY>
</HTML>



--=-17fb5Nzq1kpzHx/eoJMe--

--=-vqnDWnzTHZyIsmDt2XvH
Content-Disposition: attachment; filename="testplugin.c"
Content-Type: text/x-csrc; name="testplugin.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/**
 * vim: tabstop=2:shiftwidth=2:softtabstop=2:expandtab
 * Plugin demonstrating the use of
 * https://community.openvpn.net/openvpn/ticket/15
 *
 * It simulates a user session where
 *
 * authentication occurs
 * user bandwidth consumption is updated to accounting server regularly
 * session close
 *
 * compile with 
 * gcc -shared -Wl,-soname,accounting-test.so -o \
 * accounting-test.so testplugin.c
 */

/*
 * server conf:
 * plugin /path/to/accounting-test.so
 *
 * server need to be configured with --enable-accounting
 * which is available in patch attached to 
 * https://community.openvpn.net/openvpn/ticket/15
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdarg.h>
#include <time.h>


#include "openvpn-plugin.h"

/*
 * Our context, where we keep our state.
 */

struct plugin_context{
  char *context;
};

char *strdupf (const char *fmt, ...);
const char *get_env (const char *name, const char *envp[]);

OPENVPN_EXPORT openvpn_plugin_handle_t
openvpn_plugin_open_v2 (unsigned int *type_mask, const char *argv[],
                        const char *envp[], struct openvpn_plugin_string_list **return_list)
{
  struct plugin_context *context;
	int rc = 0;


  /*
   * Allocate our context
   */
  context = malloc (sizeof (struct plugin_context));

  *type_mask = OPENVPN_PLUGIN_MASK ( OPENVPN_PLUGIN_CLIENT_CONNECT_V2) | 
                OPENVPN_PLUGIN_MASK ( OPENVPN_PLUGIN_CLIENT_DISCONNECT ) |
                OPENVPN_PLUGIN_MASK ( OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY ) |
                OPENVPN_PLUGIN_MASK ( OPENVPN_PLUGIN_ACCOUNTING );
  return (openvpn_plugin_handle_t) context;
}

OPENVPN_EXPORT int
openvpn_plugin_func_v2 (openvpn_plugin_handle_t handle, const int type,
                        const char *argv[], const char *envp[],
                        void *per_client_context,  struct openvpn_plugin_string_list **return_list)
{
  struct plugin_context *context = (struct plugin_context *) handle;
  int acc_time;
  time_t now;
  char *now_str;

  time(&now);
  now_str = ctime(&now);
  if (type == OPENVPN_PLUGIN_CLIENT_CONNECT_V2){
    acc_time = rand()%20 + 1;
    *return_list = malloc (sizeof (struct openvpn_plugin_string_list));
    (*return_list)->next = NULL;
    (*return_list)->name = strdup ("config");
    (*return_list)->value = strdupf("accounting-freq %d", acc_time);
    printf ("ACCT %s Sending start time to accounting server %s\n", now_str, get_env("time_unix", envp));
    printf ("ACCT %s Plugin requested accounting update in %d seconds\n", now_str, acc_time);
    return OPENVPN_PLUGIN_FUNC_SUCCESS;
  }
  if (type == OPENVPN_PLUGIN_ACCOUNTING){
      const char *tx, *rx;
      tx = get_env("bytes_sent", envp);
      rx = get_env("bytes_received", envp);
      printf ("ACCT %s Sending accounting information to server %stx/%srx\n", now_str, tx ? tx : "0", rx ? rx : "0");
      *return_list = malloc (sizeof (struct openvpn_plugin_string_list));
      (*return_list)->next = NULL;
      (*return_list)->name = strdup ("config");
      acc_time = rand() % 20 + 1;
      (*return_list)->value = strdupf("accounting-freq %d", acc_time);
      printf("ACCT %s Acounting server requesting new update in %d seconds\n", now_str, acc_time);

    return OPENVPN_PLUGIN_FUNC_SUCCESS;
  }

  if (type == OPENVPN_PLUGIN_CLIENT_DISCONNECT){
      const char *tx, *rx;
      tx = get_env("bytes_sent", envp);
      rx = get_env("bytes_received", envp);

    printf ("ACCT %s Sending accounting information to server %stx/%srx, session started at %s and last %s\n", 
              now_str, tx ? tx : "0", rx ? rx : "0",
              get_env("time_unix", envp), get_env("time_duration", envp));
    return OPENVPN_PLUGIN_FUNC_SUCCESS;
  }
  if (type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY){
    return OPENVPN_PLUGIN_FUNC_SUCCESS;
  } 
	return OPENVPN_PLUGIN_FUNC_ERROR;
}

/**
 * plugin_close_v1:
 * Called immediately prior to plug-in unload
 */
OPENVPN_EXPORT void
openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
{
  struct plugin_context *context = (struct plugin_context *) handle;
  free (context);
}

const char *
get_env (const char *name, const char *envp[])
{
  if (envp){
    int i;
    const int namelen = strlen (name);
    for (i = 0; envp[i]; ++i){
      if (!strncmp (envp[i], name, namelen))
	    {
	      const char *cp = envp[i] + namelen;
	      if (*cp == '=')
		      return cp + 1;
	    }
	  }
  }
  return NULL;
}



char *
strdupf (const char *fmt, ...){
  va_list  vargs;
  char     buf[BUFSIZ];
  char    *p;

  if (!fmt) {
    return (NULL);
  }
  va_start (vargs, fmt);
  vsnprintf (buf, sizeof (buf), fmt, vargs);
  va_end (vargs);

  buf[sizeof (buf) - 1] = '\0';        /* ensure buf is NUL-terminated */

  if (!(p = strdup (buf))) {
    return (NULL);
  }
  return (p);
}



--=-vqnDWnzTHZyIsmDt2XvH--



