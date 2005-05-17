From: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Message-ID: <d6dh8d$g4o$1@...165...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...> <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...> <Pine.LNX.4.58.0505031000150.1970@...41...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Radius support (Authentification, Authorization and Accounting)
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
Date: Tue May 17 12:47:05 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello.

Thank you for all the ideas.

I think I will do the radius plugin in the following way:

1. Authentication:
split privilege execution model
plugin: OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY

- Attributes ACCECP-REQUEST:
  - Username
  - Password
  - NAS-Port = unique for each user, increment if a user connects, 
               decrement if a user disconnects
  - NAS-IP-Address = ip address of the openvpn server
  - NAS-Identifier = user defined string
  - Service Type = "Framed"  (for framed ip address assignment)
  
  So I will manage the number of the NAS-Port, I think this is the
  easiest way. 
  Or are there great advantages if every user gets his own tun
  interface? 
  To Torge Szczepanek: Which radius server do you use?
        I use freeradius and I think I can only set
        a static IP addres as "Framed IP Address".
        I don't know how dynamic ip assigment works
        on a radius server. But I will implement the 
        radius attributes NAS-Port, NAS-IP-Adress, NAS_Identifier
        and Service-Type="Framed" in the ACCEPT-REQUEST.
        Are these all attributes?

- Analyzed Attributes of the ACCESS-ACCEPT (no changes):
  Framed-Route = set to the server routing table and 
                 write to the client file in client-config-dir 
                 with the iroute directive
  Framed-IP-Address = write to the client file in the client-config-dir
                         with the (ifconfig Framed-IP IP2) directive, 
                         the other point (IP2)
                         must be create maybe by (IP2+1).
  Acct-Interim-Interval = the accounting interval
 
 (Maybe later a vendor specific attributs for routes which can be pushed to
 the client.)

2. Accounting:
- split privilege execution model, only one process with a scheduler
  for the differnt Acct-Interim-Intervals of the user.
plugin: OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
plugin: PLUGIN_CLIENT_DISCONNECT (for stop ticket)

Attributes:
 Acct-Status-Type: 
         start - at the beginning of the connection
         update - during the connection
         stop - at the end
 NAS-Session-ID: unique for a connection
 NAS-Identidier: user-defined value
 Acct-Input-Octets: read from the status file
 Acct-Output-Octets: read from the status file
 Acct-Session-Time: internal counter or read from the status file
 Framed-IP-Address: if the client get one

I will do the reading of the status file in a seperate function,
so it can be changed easy if the plugin OPENVPN_PLUGIN_STATS
is finished.

One more question to the plugin PLUGIN_CLIENT_DISCONNECT:
Does every plugin which is called, gets the pointer to thesame 
struct openvpn_plugin_handle_t, so I can save here the socket to 
the background processes and the plugin PLUGIN_CLIENT_DISCONNECT
can send data to these socket numbers?

The openvpn-plugin_abort_v1 function will I add maybe later.

Are there some more ideas or hints?

Ralf




James Yonan wrote:

> On Tue, 3 May 2005, Ralf [iso-8859-1] Lübben wrote:
> 
>> Hello,
>> 
>> I tried to create a concept for the RADIUS-Plugin.
>> Maybe someone have some additional ideas or can answer me some questions
>> I wrote down in the following text.
>> 
>>
-------------------------------------------------------------------------------------------------------------
>> Start of the connection:
>> 
>> The plugin sends a "access-request-radius-ticket" with the username and a
>> hash(MD5-hash over the password and the shared-secret)  to the radius
>> server. If the server sends a "access-reject-ticket" or
>> "access-challenge-ticket" the authorization fails.
>> 
>> If the server sends a "access-accept-ticket" the authorization is ok, in
>> the ticket can be some attributes:
>> 
>> - Framed-IP-Address: The IP-address which is pushed to the client.
>> 
>> - Framed-Route: These routes have to pushed to the servers routing table.
>> This
>> attribut can occur several times in the  "access-accept-ticket".
> 
> You might need a split privilege model here, because adding routes
> requires root privileges, and for security reasons, we don't want to run
> the main OpenVPN process as root.  The OpenVPN plugin model supports split
> privileges, i.e. where the plugin process holds onto root while the main
> OpenVPN process drops privileges (see auth-pam or down-root for examples
> of this), so you'd probably need to have the plugin fork a process to
> handle route additions.
> 
>> - Acct-Interim-Interval: The interval in which the accounting data is
>> sent to the radius server.
>> 
>> Maybe these attributes are not important :
>> - Session-Timeout: The maximum time for a connection.
> 
> OpenVPN doesn't support this right now.
> 
>> - Idle-Timeout: The connection is disconnected, if there is no traffic
> 
> This is tricky, because how do you define traffic?
> 
>> Maybe it is possible to create a vendor specific attribut for routes
>> which are pushed to the client. There is no attribut for that in the
>> radius protocol.
> 
> Good idea.
> 
>> After the authorization is done:
>> The plugin has to start another process/thread for the accounting data 
>> with the parameter value of the attribut "Acct-Interim-Interval".
>> This process has to sent an "accounting-request-ticket" to the radius
>> server with the attribut "acct-status-type"=1 (start). (There must be
>> included some more attributes for the radius server (NAS-IP-address
>> (=openvpn-ip-address) or NAS-identifier, real ip address of the user as
>> framed-ip-address-attribut, NAS-Port or NAS-port-type)
>> The process has to wait for a "accounting-response-ticket" from the
>> server, if he gets no response he has to send the ticket again
>> (interval=?).
>> 
>> The plugin must return 0 if everything is ok, otherwise 1.
>> 
>> Questions:
>> 
>> Which is the best plugin to use? I need the username and the password
>> before the ip address and the routes are sent to the client?
> 
> Use OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY (called first) to authorize
> username/password and OPENVPN_PLUGIN_CLIENT_CONNECT (called next) to push
> IP address and routes to client.
> 
>> Do the openvpn process waits until the plugin is finished? So I can write
>> the conf-files without getting a IO-error.
> 
> With 2.0.x, OpenVPN is running in a single thread, so plugin callbacks
> will stall the whole process.
> 
> For 2.1, there will be multithread support (two threads actually), so
> calls to plugins will occur from a different thread than the main packet
> forwarding thread.  There will only be a single thread for calling
> plugins, so you won't need to make the plugin callbacks themselves
> reentrant.
> 
>>
------------------------------------------------------------------------------------------------------------
>> During the connection:
>> 
>> The separate process/thread which is started at the beginning of the
>> connection sends
>> with the interval time of the  attribut "Acct-Interim-Interval"
>> accounting data to the radius server.
>> The process reads the information out of the status file which is
>> generated by the openvpn process every second. The status file must be
>> generated every second because the attribut "Acct-Interim-Interval" is in
>> seconds and so nobody knows, when ths process reads the status file.
> 
> This would work, but it might be cleaner for OpenVPN 2.1 to add a new
> callback for passing accounting data to the plugin.
> 
> The problem with polling the status file is that there's no guarantee of
> change atomicity, i.e. an entry could be added and then deleted from the
> file between pollings.
> 
>> The attribut "acct-status-type" must be set to 3 (interim-Update).
>> 
>> The process has to wait for a "accounting-response-ticket" from the
>> server, if he gets no response he has to send the ticket again
>> (interval=?).
>> 
>> Attributes in the accounting-request-ticket:
>> - NAS ip address and NAS identifier
>> - Framed ip address (=real ip address of the client)
>> - NAS-port or NAS-port-type
>> - Acct-Input-Octets
>> - Acct-Output-Octets
>> - Acct-Input-Packets
>> - Acct-Output-Packets
>> - Acct-Session-Time
>> 
>> 
>> Questions:
>> Is it possible to generate the status file every second?
> 
> Yes, however if the OpenVPN event loop is not actively forwarding packets,
> the status file update interval could be as long as 10 seconds.
> 
>> Is the accounting information in the status file separate for every user?
> 
> Yes.
> 
>> Which information can I get from the status file?
> 
> For each client:
> 
>   Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since
> 
> For each internal routing table entry:
> 
>   Virtual Address,Common Name,Real Address,Last Reference
> 
>>
------------------------------------------------------------------------------------------------------
>> End of the connection:
>> At the end a "accounting-request-ticket" with the "acct-status-type"=2
>> (stop) must be sent to the radius server.
>> With the following attributes:
>> - NAS ip address and NAS identifier
>> - Framed ip address (=real ip address of the client)
>> - NAS-port or NAS-port-type
>> - Acct-Input-Octets
>> - Acct-Output-Octets
>> - Acct-Input-Packets
>> - Acct-Output-Packets
>> - Acct-Session-Time
>> (- Acct-Terminate-Cause)
>> 
>> Also the accouting process must be killed.
>> 
>> I think the "PLUGIN_CLIENT_DISCONNECT"-type will be fit for this.
>> 
>> Questions:
>> Is the "PLUGIN_CLIENT_DISCONNECT"-type called at every disconnect?
> 
> Yes, but sometimes there is a delay on UDP disconnects, since UDP is
> connectionless, so the call to PLUGIN_CLIENT_DISCONNECT might occur more
> than 1 minute after the actual disconnection.  Also, with UDP, if a client
> disconnects and immediately reconnects using the same port number (if
> nobind isn't used on the client), the server will see both the original
> connection and the reconnect as being part of the same connection, so
> there won't be a call to PLUGIN_CLIENT_DISCONNECT then
> PLUGIN_CLIENT_CONNECT.
> 
> James
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r



