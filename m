Mime-Version: 1.0 (Apple Message framework v753.1)
Message-Id: <EB764DD2-6C72-4A24-BCB8-F9E7297ECA9C@...1169...>
From: Gerd Pauli <gp@...1169...>
Date: Mon, 15 Dec 2008 17:06:30 +0100
Subject: [Openvpn-devel] dynamic push buffer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi guys,

first of all I want to say thank you to all openvpn developers for  
making such a
cool and usefull tool. While working with it, we found two  
limitations regarding
the "IP Routing Table". There is a static buffer holding the routes.
The limit is defined in route.h ( #define MAX_ROUTES 100 ).
The second limit is the size of the push buffer ( see options.h
#define MAX_PUSH_LIST_LEN TLS_CHANNEL_BUF_SIZE / 2 )
To avoid this problem I found a patch from peter warasin in 2007 for
openvpn 2.0.9.
This is the patch for the same problem adapted to openvpn 2.1_rc15.
If you find the patch useful please integrate it in the next release.
The patch is backward compatible as long as the push list will not
overflow the MAX_PUSH_LIST_LEN limit.


*** openvpn-2.1_rc15/options.c  Tue Nov 18 05:59:13 2008
--- openvpn-2.1_rc15_hc/options.c       Tue Dec  9 10:23:24 2008
***************
*** 941,946 ****
--- 941,947 ----
   show_p2mp_parms (const struct options *o)
   {
     struct gc_arena gc = gc_new ();
+   struct push_list_item *item = NULL;

   #if P2MP_SERVER
     msg (D_SHOW_PARMS, "  server_network = %s", print_in_addr_t (o- 
 >server_network, 0, &gc));
***************
*** 951,959 ****
     msg (D_SHOW_PARMS, "  server_bridge_pool_end = %s",  
print_in_addr_t (o->server_bridge_pool_end, 0, &gc));
     if (o->push_list)
       {
!       const struct push_list *l = o->push_list;
!       const char *printable_push_list = l->options;
!       msg (D_SHOW_PARMS, "  push_list = '%s'", printable_push_list);
       }
     SHOW_BOOL (ifconfig_pool_defined);
     msg (D_SHOW_PARMS, "  ifconfig_pool_start = %s", print_in_addr_t  
(o->ifconfig_pool_start, 0, &gc));
--- 952,963 ----
     msg (D_SHOW_PARMS, "  server_bridge_pool_end = %s",  
print_in_addr_t (o->server_bridge_pool_end, 0, &gc));
     if (o->push_list)
       {
!       msg (D_SHOW_PARMS, "  push_list = {");
!       for (item = o->push_list->options; item != NULL; item = item- 
 >next)
!         {
!           msg (D_SHOW_PARMS, "    %s", item->item);
!         }
!       msg (D_SHOW_PARMS, "              }");
       }
     SHOW_BOOL (ifconfig_pool_defined);
     msg (D_SHOW_PARMS, "  ifconfig_pool_start = %s", print_in_addr_t  
(o->ifconfig_pool_start, 0, &gc));
***************
*** 998,1003 ****
--- 1002,1021 ----

   #endif /* ENABLE_DEBUG */

+
+ void
+ add_push_option(struct push_list *pl, struct gc_arena *gc, const  
char *option)
+ {
+   struct push_list_item *item;
+
+   ALLOC_OBJ_CLEAR_GC (item, struct push_list_item, gc);
+   strncpy(item->item, option, sizeof(item->item));
+
+   item->next = pl->options;
+   pl->options = item;
+ }
+
+
   #if P2MP_SERVER

   static void
***************
*** 1051,1064 ****
   void
   options_detach (struct options *o)
   {
     gc_detach (&o->gc);
     o->routes = NULL;
   #if P2MP_SERVER
     if (o->push_list) /* clone push_list */
       {
         const struct push_list *old = o->push_list;
!       ALLOC_OBJ_GC (o->push_list, struct push_list, &o->gc);
!       strcpy (o->push_list->options, old->options);
       }
   #endif
   }
--- 1069,1085 ----
   void
   options_detach (struct options *o)
   {
+   struct gc_arena gc = o->gc;
     gc_detach (&o->gc);
     o->routes = NULL;
   #if P2MP_SERVER
     if (o->push_list) /* clone push_list */
       {
         const struct push_list *old = o->push_list;
!       struct push_list_item *item = NULL;
!       ALLOC_OBJ_CLEAR_GC (o->push_list, struct push_list, &o->gc);
!       for (item = old->options; item != NULL; item = item->next)
!         add_push_option(o->push_list, &o->gc, item->item);
       }
   #endif
   }
***************
*** 3177,3200 ****
       }
   }

   bool
   apply_push_options (struct options *options,
-                   struct buffer *buf,
                     unsigned int permission_mask,
                     unsigned int *option_types_found,
                     struct env_set *es)
   {
-   char line[OPTION_PARM_SIZE];
     int line_num = 0;
     const char *file = "[PUSH-OPTIONS]";
     const int msglevel = D_PUSH_ERRORS|M_OPTERR;

!   while (buf_parse (buf, ',', line, sizeof (line)))
       {
         char *p[MAX_PARMS];
         CLEAR (p);
         ++line_num;
!       if (parse_line (line, p, SIZE (p), file, line_num, msglevel,  
&options->gc))
         {
           add_option (options, p, file, line_num, 0, msglevel,  
permission_mask, option_types_found, es);
         }
--- 3198,3254 ----
       }
   }

+ void
+ push_list_to_buf(struct push_list *pl, struct buffer *buf)
+ {
+   struct push_list_item *item;
+   bool first = true;
+
+   if (! pl)
+     return;
+
+   for (item = pl->options; item != NULL; item = item->next)
+     if (first)
+       buf_printf(buf, "%s", item->item);
+     else
+       buf_printf(buf, ",%s", item->item);
+ }
+
+ void
+ store_pull_buffer (struct options *options,
+                  struct buffer *buf)
+ {
+   char line[OPTION_PARM_SIZE];
+
+   if (options->pull_buffer == NULL)
+     ALLOC_OBJ_CLEAR_GC (options->pull_buffer, struct push_list,  
&options->gc);
+
+   while (buf_parse (buf, ',', line, sizeof (line)))
+     add_push_option(options->pull_buffer, &options->gc, line);
+
+   options->pull_buffer->chunks++;
+ }
+
   bool
   apply_push_options (struct options *options,
                     unsigned int permission_mask,
                     unsigned int *option_types_found,
                     struct env_set *es)
   {
     int line_num = 0;
     const char *file = "[PUSH-OPTIONS]";
     const int msglevel = D_PUSH_ERRORS|M_OPTERR;
+   struct push_list_item *item = NULL;

!   if (! options->pull_buffer)
!     return true;
!
!   for (item = options->pull_buffer->options; item != NULL; item =  
item->next)
       {
         char *p[MAX_PARMS];
         CLEAR (p);
         ++line_num;
!       if (parse_line (item->item, p, SIZE (p), file, line_num,  
msglevel, &options->gc))
         {
           add_option (options, p, file, line_num, 0, msglevel,  
permission_mask, option_types_found, es);
         }
*** openvpn-2.1_rc15/options.h  Tue Nov 18 05:43:47 2008
--- openvpn-2.1_rc15_hc/options.h       Tue Dec  9 10:23:24 2008
***************
*** 60,70 ****
   #if P2MP_SERVER
   /* parameters to be pushed to peer */

! #define MAX_PUSH_LIST_LEN TLS_CHANNEL_BUF_SIZE /* This parm is  
related to PLAINTEXT_BUFFER_SIZE in ssl.h */

   struct push_list {
     /* newline delimited options, like config file */
!   char options[MAX_PUSH_LIST_LEN];
   };
   #endif

--- 60,83 ----
   #if P2MP_SERVER
   /* parameters to be pushed to peer */

! /* keep for backwards compatibility */
! #define MAX_PUSH_LIST_LEN TLS_CHANNEL_BUF_SIZE / 2 /* This parm is  
related to PLAINTEXT_BUFFER_SIZE in ssl.h */
!
! struct push_list_item {
!   /* one option per entry, items are like config file */
!   char item[OPTION_LINE_SIZE];
!   struct push_list_item *next;
! };

   struct push_list {
     /* newline delimited options, like config file */
!   struct push_list_item *options;
!
!   /* points to the next to be sent item */
!   struct push_list_item *sent;
!
!   /* chunk counter */
!   int chunks;
   };
   #endif

***************
*** 358,363 ****
--- 371,377 ----
     in_addr_t server_bridge_pool_end;

     struct push_list *push_list;
+   struct push_list *pull_buffer;
     bool ifconfig_pool_defined;
     in_addr_t ifconfig_pool_start;
     in_addr_t ifconfig_pool_end;
***************
*** 631,641 ****
   void pre_pull_restore (struct options *o);

   bool apply_push_options (struct options *options,
-                        struct buffer *buf,
                          unsigned int permission_mask,
                          unsigned int *option_types_found,
                          struct env_set *es);

   bool is_persist_option (const struct options *o);
   bool is_stateful_restart (const struct options *o);

--- 645,659 ----
   void pre_pull_restore (struct options *o);

   bool apply_push_options (struct options *options,
                          unsigned int permission_mask,
                          unsigned int *option_types_found,
                          struct env_set *es);

+ void add_push_option(struct push_list *pl, struct gc_arena *gc,  
const char *option);
+ void push_list_to_buf(struct push_list *pl, struct buffer *buf);
+ void store_pull_buffer (struct options *options,
+                       struct buffer *buf);
+
   bool is_persist_option (const struct options *o);
   bool is_stateful_restart (const struct options *o);

*** openvpn-2.1_rc15/push.c     Mon Oct  6 09:22:21 2008
--- openvpn-2.1_rc15_hc/push.c  Tue Dec  9 10:23:24 2008
***************
*** 99,104 ****
--- 99,109 ----

     if (status == PUSH_MSG_ERROR)
       msg (D_PUSH_ERRORS, "WARNING: Received bad push/pull message: % 
s", BSTR (buffer));
+   else if (status == PUSH_MSG_CHUNKED_REPLY)
+     {
+       if (option_types_found)
+       do_deferred_options (c, option_types_found);
+     }
     else if (status == PUSH_MSG_REPLY)
       {
         do_up (c, true, option_types_found); /* delay bringing tun/ 
tap up until --push parms received from remote */
***************
*** 115,151 ****
   }

   #if P2MP_SERVER
   bool
   send_push_reply (struct context *c)
   {
     struct gc_arena gc = gc_new ();
     struct buffer buf = alloc_buf_gc (MAX_PUSH_LIST_LEN + 256, &gc);
     bool ret = false;

!   buf_printf (&buf, "PUSH_REPLY");
!
!   if (c->options.push_list && strlen (c->options.push_list->options))
!     buf_printf (&buf, ",%s", c->options.push_list->options);

!   if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local && c- 
 >c2.push_ifconfig_remote_netmask)
!     buf_printf (&buf, ",ifconfig %s %s",
!               print_in_addr_t (c->c2.push_ifconfig_local, 0, &gc),
!               print_in_addr_t (c->c2.push_ifconfig_remote_netmask,  
0, &gc));

!   if (strlen (BSTR (&buf)) < MAX_PUSH_LIST_LEN)
!     ret = send_control_channel_string (c, BSTR (&buf), D_PUSH);
     else
!     msg (M_WARN, "Maximum length of --push buffer (%d) has been  
exceeded", MAX_PUSH_LIST_LEN);

     gc_free (&gc);
     return ret;
   }

   void
   push_option (struct options *o, const char *opt, int msglevel)
   {
     int len;
-   bool first = false;

     if (!string_class (opt, CC_ANY, CC_COMMA))
       {
--- 120,216 ----
   }

   #if P2MP_SERVER
+
+ bool
+ create_next_chunk(struct buffer *buf, struct options *o)
+ {
+   struct push_list *pl = o->push_list;
+   struct push_list_item *item;
+
+   if (pl == NULL)
+       return false;
+
+   if (pl->sent == NULL)
+       pl->sent = pl->options;
+
+   pl->chunks++;
+
+   item = pl->sent;
+   while (item && (strlen (BSTR (buf)) < MAX_PUSH_LIST_LEN))
+     {
+       buf_printf (buf, ",%s", item->item);
+       item = item->next;
+     }
+   pl->sent = item;
+
+   if (item)
+     return true;
+   return false;
+ }
+
   bool
   send_push_reply (struct context *c)
   {
     struct gc_arena gc = gc_new ();
     struct buffer buf = alloc_buf_gc (MAX_PUSH_LIST_LEN + 256, &gc);
+   struct buffer push_buf = alloc_buf_gc (MAX_PUSH_LIST_LEN + 256,  
&gc);
+   struct push_list *pl = NULL;
     bool ret = false;
+   bool more_chunks = false;
+   bool first_chunk = false;

!   if (c->options.push_list && !c->options.push_list->sent)
!     first_chunk = true;

!   if (c->options.push_list)
!     more_chunks = create_next_chunk(&push_buf, &c->options);
!   else
!     first_chunk = true;

!   if (! more_chunks)
!     buf_printf (&buf, "PUSH_REPLY");
     else
!     buf_printf (&buf, "PUSH_CHUNKED_REPLY");
!
!   if (! more_chunks)
!     {
!       if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local  
&& c->c2.push_ifconfig_remote_netmask)
!         buf_printf (&buf, ",ifconfig %s %s",
!                   print_in_addr_t (c->c2.push_ifconfig_local, 0, &gc),
!                   print_in_addr_t (c- 
 >c2.push_ifconfig_remote_netmask, 0, &gc));
!     }
!
!   buf_printf (&buf, "%s", BSTR(&push_buf));
!
!   if (more_chunks)
!     msg (M_WARN, "Maximum length of --push buffer (%d) has been  
exceeded. Send as chunks. Old clients will accept only the last  
chunk", MAX_PUSH_LIST_LEN);
!
!   ret = send_control_channel_string (c, BSTR (&buf), D_PUSH);

     gc_free (&gc);
     return ret;
   }

+ bool
+ push_buffer_exceeded(struct push_list_item *pl)
+ {
+   int size = 0;
+   struct push_list_item *item = NULL;
+   if (! pl)
+     return false;
+   for (item = pl; item != NULL; item = item->next)
+     {
+       size += strlen(item->item) + 2;
+       if (size >= MAX_PUSH_LIST_LEN)
+         return true;
+     }
+   return false;
+ }
+
   void
   push_option (struct options *o, const char *opt, int msglevel)
   {
     int len;

     if (!string_class (opt, CC_ANY, CC_COMMA))
       {
***************
*** 154,175 ****
     else
       {
         if (!o->push_list)
!       {
           ALLOC_OBJ_CLEAR_GC (o->push_list, struct push_list, &o->gc);
!         first = true;
!       }
!
!       len = strlen (o->push_list->options);
!       if (len + strlen (opt) + 2 >= MAX_PUSH_LIST_LEN)
!       {
!         msg (msglevel, "Maximum length of --push buffer (%d) has  
been exceeded", MAX_PUSH_LIST_LEN);
!       }
!       else
!       {
!         if (!first)
!           strcat (o->push_list->options, ",");
!         strcat (o->push_list->options, opt);
!       }
       }
   }

--- 219,228 ----
     else
       {
         if (!o->push_list)
!         {
           ALLOC_OBJ_CLEAR_GC (o->push_list, struct push_list, &o->gc);
!         }
!       add_push_option(o->push_list, &o->gc, opt);
       }
   }

***************
*** 219,243 ****
     else
   #endif

!   if (honor_received_options && buf_string_compare_advance (&buf,  
"PUSH_REPLY"))
       {
!       const uint8_t ch = buf_read_u8 (&buf);
!       if (ch == ',')
!       {
!         pre_pull_restore (&c->options);
!         c->c2.pulled_options_string = string_alloc (BSTR (&buf), &c- 
 >c2.gc);
!         if (apply_push_options (&c->options,
!                                 &buf,
!                                 permission_mask,
!                                 option_types_found,
!                                 c->c2.es))
             ret = PUSH_MSG_REPLY;
!       }
!       else if (ch == '\0')
!       {
!         ret = PUSH_MSG_REPLY;
!       }
!       /* show_settings (&c->options); */
       }
     return ret;
   }
--- 272,319 ----
     else
   #endif

!   if (honor_received_options)
       {
!       bool chunked = buf_string_compare_advance (&buf,  
"PUSH_CHUNKED_REPLY");
!       bool reply = buf_string_compare_advance (&buf, "PUSH_REPLY");
!
!       if (reply || chunked)
!         {
!           const uint8_t ch = buf_read_u8 (&buf);
!           if (ch == ',')
!           {
!               store_pull_buffer(&c->options, &buf);
!               event_timeout_init (&c->c2.push_request_interval, 1,  
now);
!               reset_coarse_timers (c);
!
!               if (chunked)
!               ret = PUSH_MSG_CHUNKED_REPLY;
!               else
!               ret = PUSH_MSG_REPLY;
!           }
!           else if (ch == '\0')
             ret = PUSH_MSG_REPLY;
!
!           if (ret == PUSH_MSG_REPLY)
!             {
!             pre_pull_restore (&c->options);
!             if (apply_push_options (&c->options,
!                                     permission_mask,
!                                     option_types_found,
!                                     c->c2.es))
!                 {
!                   struct buffer pull_list = alloc_buf_gc  
((MAX_PUSH_LIST_LEN + 256)*4, &c->c2.gc);
!
!                   push_list_to_buf(c->options.pull_buffer,  
&pull_list);
!                 c->c2.pulled_options_string = string_alloc (BSTR  
(&pull_list), &c->c2.gc);
!                   c->options.pull_buffer = NULL;
!                 }
!                 /* show_settings (&c->options); */
!               else
!               ret = PUSH_MSG_ERROR;
!
!             }
!         }
       }
     return ret;
   }
***************
*** 252,278 ****
     if (o && o->push_list && o->iroutes)
       {
         struct gc_arena gc = gc_new ();
!       struct push_list *pl;
!       struct buffer in, out;
!       char *line;
!       bool first = true;
!
!       /* prepare input and output buffers */
!       ALLOC_OBJ_CLEAR_GC (pl, struct push_list, &gc);
!       ALLOC_ARRAY_CLEAR_GC (line, char, MAX_PUSH_LIST_LEN, &gc);
!
!       buf_set_read (&in, (const uint8_t*) o->push_list->options,  
strlen (o->push_list->options));
!       buf_set_write (&out, (uint8_t*) pl->options, sizeof (pl- 
 >options));

         /* cycle through the push list */
!       while (buf_parse (&in, ',', line, MAX_PUSH_LIST_LEN))
         {
           char *p[MAX_PARMS];
!         bool copy = true;

           /* parse the push item */
           CLEAR (p);
!         if (parse_line (line, p, SIZE (p), "[PUSH_ROUTE_REMOVE]",  
1, D_ROUTE_DEBUG, &gc))
             {
               /* is the push item a route directive? */
               if (p[0] && !strcmp (p[0], "route") && !p[3])
--- 328,345 ----
     if (o && o->push_list && o->iroutes)
       {
         struct gc_arena gc = gc_new ();
!       struct push_list_item *prev = NULL;
!       struct push_list_item *item = NULL;

         /* cycle through the push list */
!       for (item = o->push_list->options; item != NULL; item = item- 
 >next)
         {
           char *p[MAX_PARMS];
!           bool copy = true;

           /* parse the push item */
           CLEAR (p);
!         if (parse_line (item->item, p, SIZE (p),  
"[PUSH_ROUTE_REMOVE]", 1, D_ROUTE_DEBUG, &gc))
             {
               /* is the push item a route directive? */
               if (p[0] && !strcmp (p[0], "route") && !p[3])
***************
*** 300,324 ****
                 }
             }

!         /* should we copy the push item? */
!         if (copy)
!           {
!             if (!first)
!               buf_printf (&out, ",");
!             buf_printf (&out, "%s", line);
!             first = false;
!           }
!         else
!           msg (D_PUSH, "REMOVE PUSH ROUTE: '%s'", line);
         }

- #if 0
-       msg (M_INFO, "BEFORE: '%s'", o->push_list->options);
-       msg (M_INFO, "AFTER:  '%s'", pl->options);
- #endif
-
-       /* copy new push list back to options */
-       *o->push_list = *pl;

         gc_free (&gc);
       }
--- 367,384 ----
                 }
             }

!         /* should we remove the push items? */
!         if (! copy)
!             {
!             msg (D_PUSH, "REMOVE PUSH ROUTE: '%s'", item->item);
!               if (prev)
!                   prev->next = item->next;
!               else
!                   o->push_list->options = item->next;
!             }
!           prev = item;
         }


         gc_free (&gc);
       }
*** openvpn-2.1_rc15/push.h     Mon Oct  6 09:22:20 2008
--- openvpn-2.1_rc15_hc/push.h  Tue Dec  9 10:23:24 2008
***************
*** 34,39 ****
--- 34,40 ----
   #define PUSH_MSG_REPLY            2
   #define PUSH_MSG_REQUEST_DEFERRED 3
   #define PUSH_MSG_AUTH_FAILURE     4
+ #define PUSH_MSG_CHUNKED_REPLY    5

   void incoming_push_message (struct context *c,
                             const struct buffer *buffer);






CU
--
Gerd Pauli
http://www.high-consulting.de



